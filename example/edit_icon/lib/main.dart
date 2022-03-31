// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:io';
import 'dart:math';

import 'package:betrayal/betrayal.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Betrayal Demo',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 199, 184, 116),
              brightness: Brightness.light)),
      darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 199, 184, 116),
              brightness: Brightness.dark)),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TrayIcon _icon = TrayIcon(const TrayIconData());

  @override
  void dispose() {
    _icon.dispose();
    super.dispose();
  }

  final _items = [
    ElementSelectorData((_) => const FlutterLogo()),
    ElementSelectorData((_) => const FlutterLogo()),
    ElementSelectorData((_) => const FlutterLogo()),
  ];

  late final _delegate = ElementSelectorDelegate(initialItems: _items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElementSelector(
      axis: Axis.vertical,
      onSelectionChanged: (index) {
        _icon.setTooltip(_delegate.elementAt(index).key.toString());
        _icon.setIcon();
        _icon.show();
      },
      delegate: _delegate,
      onAddPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom, allowedExtensions: const ["ico", "png"]);
        if (result == null) return;
        final path = result.files.first.path!;
        _delegate.add(ElementSelectorData((_) => Image.file(File(path))));
      },
    ));
  }
}

class ElementSelectorData {
  ElementSelectorData(this.widget, {Key? key}) {
    this.key = key ?? GlobalKey();
  }

  final Function(BuildContext) widget;
  late final Key key;
}

class ElementSelectorDelegate {
  ElementSelectorDelegate({Iterable<ElementSelectorData>? initialItems}) {
    _items = initialItems?.toList() ?? <ElementSelectorData>[];
  }

  late final List<ElementSelectorData> _items;
  get numItems => _items.length;
  final List<ElementSelectorDelegateSubscription> _subscriptions = [];

  void add(ElementSelectorData item) async {
    _items.add(item);
    for (var sub in _subscriptions) {
      if (sub.onAdd != null) await sub.onAdd!();
    }
  }

  Future<void> removeAt(int index) async {
    _items.removeAt(index);
    for (var sub in _subscriptions) {
      if (sub.onRemove != null) await sub.onRemove!(index);
    }
  }

  ElementSelectorDelegateSubscription subscribe(
      {Function? onAdd, Function(int index)? onRemove}) {
    var sub = ElementSelectorDelegateSubscription(
        onAdd: onAdd, onRemove: onRemove, delegate: this);
    _subscriptions.add(sub);
    return sub;
  }

  void removeSubscription(ElementSelectorDelegateSubscription sub) {
    _subscriptions.remove(sub);
  }

  ElementSelectorData elementAt(int index) => _items.elementAt(index);
}

class ElementSelectorDelegateSubscription {
  ElementSelectorDelegateSubscription(
      {this.onAdd, this.onRemove, required this.delegate});
  Function? onAdd;
  Function(int index)? onRemove;
  ElementSelectorDelegate delegate;

  void unsubscribe() {
    onAdd = null;
    onRemove = null;
    delegate.removeSubscription(this);
  }
}

class ElementSelector extends StatefulWidget {
  const ElementSelector(
      {Key? key,
      this.dimension = 150,
      this.axis = Axis.vertical,
      this.onSelectionChanged,
      this.onAddPressed,
      required this.delegate})
      : super(key: key);

  final double dimension;
  final Axis axis;
  final ElementSelectorDelegate delegate;
  final Function(int index)? onSelectionChanged;
  final Function? onAddPressed;

  @override
  State<ElementSelector> createState() => _ElementSelectorState();
}

class _ElementSelectorState extends State<ElementSelector>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeOutBack,
  );

  late ElementSelectorDelegateSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.delegate.subscribe(
        onAdd: _reactToAddedElement, onRemove: _reactToRemovedElement);
  }

  @override
  void didUpdateWidget(ElementSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentPage = max(min(_currentPage, _numPages - 1), 0);
    if (oldWidget.delegate != widget.delegate) {
      _subscription.unsubscribe();
      _subscription = widget.delegate.subscribe(
          onAdd: _reactToAddedElement, onRemove: _reactToRemovedElement);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _subscription.unsubscribe();
    super.dispose();
  }

  Future<void> _reactToAddedElement() async {
    await _animationController.reverse();
    setState(() {
      _animationController.reset();
    });
  }

  Future<void> _reactToRemovedElement(int index) async {
    await _animationController.forward();
    setState(() {
      // widget.delegate.removeAt(index);
      _animationController.reset();
    });
  }

  int _currentPage = 0;
  get _numPages => widget.onAddPressed != null
      ? widget.delegate.numItems + 1
      : widget.delegate.numItems;
  late PageController _controller;

  @override
  Widget build(BuildContext context) {
    _controller = PageController(
        initialPage: _currentPage,
        viewportFraction: widget.dimension /
            (widget.axis == Axis.vertical
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.width));
    return PageView.builder(
      allowImplicitScrolling: true,
      scrollDirection: widget.axis,
      itemCount: _numPages,
      onPageChanged: (pageIndex) {
        setState(() {
          _currentPage = pageIndex;
        });
        if (widget.onSelectionChanged != null &&
            pageIndex < widget.delegate.numItems) {
          widget.onSelectionChanged!(pageIndex);
        }
      },
      itemBuilder: (BuildContext context, int index) {
        final animateHere = () {
          _controller.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut);
        };
        final isSelected = index == _currentPage;

        Widget res;

        if (widget.onAddPressed != null && index == widget.delegate.numItems) {
          res = IconButton(
            tooltip: "Add new Image",
            iconSize: widget.dimension * 0.5,
            icon: Icon(Icons.add,
                color: Theme.of(context).colorScheme.onBackground),
            onPressed: () async {
              await widget.onAddPressed!();
            },
          );
        } else {
          final item = widget.delegate._items[index];

          res = Selectable(
              axis: widget.axis,
              key: item.key,
              dimension: widget.dimension,
              onTap: animateHere,
              onRemove: () async => await widget.delegate.removeAt(index),
              isSelected: isSelected,
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: item.widget(context)));
        }

        final double slideFactor = index >= _currentPage ? -1 : 0;

        return SlideTransition(
            position: _animation.drive(Tween(
                begin: Offset.zero,
                end: Offset(
                  widget.axis == Axis.horizontal ? slideFactor : 0,
                  widget.axis == Axis.vertical ? slideFactor : 0,
                ))),
            child: res);
      },
      scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.touch
      }, scrollbars: false),
      physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
      controller: _controller,
    );
  }
}

class Selectable extends StatefulWidget {
  const Selectable(
      {Key? key,
      this.isSelected = false,
      required this.dimension,
      this.gap = 8.0,
      this.axis = Axis.vertical,
      this.onTap,
      this.child,
      this.onRemove,
      this.timeToRemove = const Duration(milliseconds: 200)})
      : super(key: key);

  final bool isSelected;
  final Axis axis;
  final Widget? child;
  final double gap;
  final double dimension;
  final Function()? onTap;
  final Function()? onRemove;
  final Duration timeToRemove;

  @override
  State<Selectable> createState() => _SelectableState();
}

class _SelectableState extends State<Selectable> {
  final iconInsetFactor = 0.7;
  late bool _isSelected = widget.isSelected;
  bool _removing = false;

  @override
  void didUpdateWidget(Selectable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transparent = theme.colorScheme.background.withOpacity(0.0);

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.axis == Axis.vertical ? widget.gap : 0,
          horizontal: widget.axis == Axis.horizontal ? widget.gap : 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.square(
            dimension: widget.dimension,
            child: Material(
              clipBehavior: Clip.antiAlias,
              type: MaterialType.circle,
              color: transparent,
              child: InkWell(
                hoverColor: _removing ? transparent : null,
                highlightColor: _removing ? transparent : null,
                onTap: widget.onTap,
                onFocusChange: (hasFocus) =>
                    hasFocus ? widget.onTap?.call() : null,
                autofocus: true,
                canRequestFocus: true,
                focusColor: transparent,
                child: AnimatedContainer(
                    duration: _removing
                        ? widget.timeToRemove
                        : const Duration(milliseconds: 800),
                    curve: Curves.ease,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isSelected
                            ? Color.lerp(theme.colorScheme.background,
                                theme.colorScheme.outline, 0.15)
                            : transparent),
                    foregroundDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: _isSelected ? 2.0 : 0,
                            color: _isSelected
                                ? theme.colorScheme.outline
                                : transparent)),
                    child: Padding(
                      padding: EdgeInsets.all(sqrt(widget.dimension)),
                      child: AnimatedOpacity(
                          opacity: _removing ? 0.0 : 1.0,
                          duration: widget.timeToRemove,
                          child: widget.child),
                    )),
              ),
            ),
          ),
          if (_isSelected && widget.onRemove != null)
            Positioned.fill(
                left: (widget.dimension -
                        (widget.axis == Axis.horizontal ? widget.gap * 2 : 0)) *
                    iconInsetFactor,
                bottom: (widget.dimension -
                        (widget.axis == Axis.vertical ? widget.gap * 2 : 0)) *
                    iconInsetFactor,
                child: Transform.scale(
                  scale: .6,
                  child: FloatingActionButton(
                    tooltip: "Remove",
                    elevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    disabledElevation: 0,
                    hoverElevation: 0,
                    onPressed: () async {
                      setState(() {
                        _isSelected = false;
                        _removing = true;
                      });
                      Focus.maybeOf(context)?.unfocus();
                      await Future.delayed(widget.timeToRemove);
                      widget.onRemove!();
                    },
                    child: Transform.rotate(
                        angle: pi / 4,
                        child: const Icon(
                          Icons.add,
                          size: 36,
                        )),
                  ),
                )),
        ],
      ),
    );
  }
}
