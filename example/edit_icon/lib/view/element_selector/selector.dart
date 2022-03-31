// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'delegate.dart';
import 'selectable.dart';
import 'subscription.dart';

class ElementSelector extends StatefulWidget {
  const ElementSelector(
      {Key? key,
      this.dimension = 150,
      this.axis = Axis.vertical,
      this.onSelectionChanged,
      this.onAddPressed,
      this.addTooltip,
      required this.delegate})
      : super(key: key);

  /// Edge length of a selectable child.
  final double dimension;

  /// Direction in which the elements are laid out.
  final Axis axis;

  /// Shown when hovering over the add button.
  final String? addTooltip;
  final ElementSelectorDelegate delegate;
  final Function(int index)? onSelectionChanged;

  /// Fire when the add button is pressed.
  /// If null, no add button will be present.
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
            tooltip: widget.addTooltip,
            iconSize: widget.dimension * 0.5,
            icon: Icon(Icons.add,
                color: Theme.of(context).colorScheme.onBackground),
            onPressed: () async {
              await widget.onAddPressed!();
            },
          );
        } else {
          final item = widget.delegate.elementAt(index);

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
