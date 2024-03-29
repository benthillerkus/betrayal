import 'dart:math';

import 'package:flutter/material.dart';

class Selectable extends StatefulWidget {
  const Selectable(
      {Key? key,
      this.axis = Axis.vertical,
      this.isSelected = false,
      required this.dimension,
      this.gap = 8.0,
      this.label,
      this.child,
      this.onTap,
      this.onRemove,
      this.onTextChanged,
      this.timeToRemove = const Duration(milliseconds: 300)})
      : super(key: key);

  final Axis axis;
  final bool isSelected;
  final double dimension;
  final double gap;
  final String? label;
  final Widget? child;
  final void Function()? onTap;
  final void Function(String)? onTextChanged;
  final void Function()? onRemove;
  final Duration timeToRemove;

  @override
  State<Selectable> createState() => _SelectableState();
}

class _SelectableState extends State<Selectable> with TickerProviderStateMixin {
  final iconInsetFactor = 0.7;
  late bool _isSelected = widget.isSelected;
  bool _removing = false;
  final _focus = FocusNode();

  @override
  void didUpdateWidget(Selectable oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isSelected = widget.isSelected;
    if (!_isSelected) {
      _focus.unfocus();
    }
    _controller.duration = widget.timeToRemove;
  }

  late final _controller = AnimationController(
    vsync: this,
    duration: widget.timeToRemove,
  );

  late final _animation =
      CurvedAnimation(parent: _controller, curve: Curves.ease);

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transparent = theme.colorScheme.background.withOpacity(0.0);

    return Stack(
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
                    child: ScaleTransition(
                      scale: _animation,
                      child: AnimatedOpacity(
                          opacity: _removing ? 0.0 : 1.0,
                          duration: widget.timeToRemove,
                          child: widget.child),
                    ),
                  )),
            ),
          ),
        ),
        if (_isSelected && widget.onRemove != null)
          Positioned.fill(
              left: widget.dimension * iconInsetFactor,
              bottom: widget.dimension * iconInsetFactor,
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
                      _controller.reverse();
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
        Transform.translate(
          offset: Offset(
              0,
              widget.dimension / 2 +
                  (theme.textTheme.bodySmall?.fontSize ?? 14) / 2 +
                  8),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Opacity(
                opacity: 0,
                child: Padding(
                    padding: EdgeInsets.all(12), child: Icon(Icons.label))),
            SizedBox(
              width: widget.dimension * 2 / 3,
              child: AnimatedOpacity(
                duration: widget.timeToRemove,
                curve: Curves.easeOut,
                opacity: _removing
                    ? 0
                    : widget.isSelected
                        ? 1
                        : .6,
                child: EditableText(
                  readOnly: !_isSelected,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall!,
                  showSelectionHandles: true,
                  textScaleFactor: 1.5,
                  keyboardAppearance: theme.brightness,
                  onChanged: widget.onTextChanged,
                  backgroundCursorColor:
                      const Color.fromARGB(255, 38, 194, 155),
                  controller: TextEditingController(text: widget.label),
                  cursorColor: theme.colorScheme.outline,
                  focusNode: _focus,
                ),
              ),
            ),
            AnimatedOpacity(
              duration: widget.timeToRemove,
              curve: Curves.easeOut,
              opacity: _removing
                  ? 0
                  : widget.isSelected
                      ? 1
                      : 0,
              child: IconButton(
                  tooltip: "Edit",
                  color: theme.colorScheme.primary,
                  padding: EdgeInsets.zero,
                  onPressed: _focus.requestFocus,
                  icon: const Icon(Icons.edit)),
            )
          ]),
        ),
      ],
    );
  }
}
