import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:joinder_app/app/shared/widgets/custom_checkbox.dart';

class AlwaysVisibleScrollbar extends StatefulWidget {
  AlwaysVisibleScrollbar.singleChild({
    Key key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.children,
    this.dragStartBehavior = DragStartBehavior.down,
    this.crossAxisCount = 2,
    this.childAspectRatio = 3,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.scrollbarColor,
    this.scrollbarThickness = 4.0,
  }) : super(key: key);

  AlwaysVisibleScrollbar.grid({
    Key key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.children,
    this.dragStartBehavior = DragStartBehavior.down,
    this.crossAxisCount = 2,
    this.childAspectRatio = 3,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.scrollbarColor,
    this.scrollbarThickness = 4.0,
  }) : super(key: key);

  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsets padding;
  final bool primary;
  final ScrollPhysics physics;
  final ScrollController controller;
  final Widget child;
  final List<Widget> children;
  final DragStartBehavior dragStartBehavior;

  // Grid View
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  // Scrollbar
  final Color scrollbarColor;
  final double scrollbarThickness;

  @override
  _AlwaysVisibleScrollbarState createState() => _AlwaysVisibleScrollbarState();
}

class _AlwaysVisibleScrollbarState extends State<AlwaysVisibleScrollbar> {
  AlwaysVisibleScrollbarPainter _scrollbarPainter;

  @override
  void initState() {
    super.initState();
    _buildChildType();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    rebuildPainter();
  }

  @override
  void didUpdateWidget(AlwaysVisibleScrollbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    rebuildPainter();
  }

  void rebuildPainter() {
    final theme = Theme.of(context);
    _scrollbarPainter = AlwaysVisibleScrollbarPainter(
      color: widget.scrollbarColor ?? theme.highlightColor.withOpacity(1.0),
      textDirection: Directionality.of(context),
      thickness: widget.scrollbarThickness,
    );
  }

  @override
  void dispose() {
    _scrollbarPainter?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: _scrollbarPainter,
        child: RepaintBoundary(child: _buildChildType()),
      ),
    );
  }

  Widget _buildChildType() {
    if (widget.child != null)
      return SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        padding: widget.padding,
        primary: widget.primary,
        physics: widget.physics,
        controller: widget.controller,
        dragStartBehavior: widget.dragStartBehavior,
        child: Builder(
          builder: (BuildContext context) {
            _scrollbarPainter.scrollable = Scrollable.of(context);
            return widget.child;
          },
        ),
      );
    else
      return GridView.builder(
          itemCount: widget.children.length,
          padding: widget.padding,
          scrollDirection: widget.scrollDirection,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisSpacing: widget.crossAxisSpacing),
          itemBuilder: (BuildContext context, int index) {
            _scrollbarPainter.scrollable = Scrollable.of(context);
            return widget.children[index];
          });
  }
}

class AlwaysVisibleScrollbarPainter extends ScrollbarPainter {
  AlwaysVisibleScrollbarPainter({
    @required Color color,
    @required TextDirection textDirection,
    @required double thickness,
  }) : super(
          color: color,
          textDirection: textDirection,
          thickness: thickness,
          fadeoutOpacityAnimation: const AlwaysStoppedAnimation(1.0),
        );

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    _scrollable?.position?.removeListener(_onScrollChanged);
    _scrollable = value;
    _scrollable?.position?.addListener(_onScrollChanged);
    _onScrollChanged();
  }

  void _onScrollChanged() {
    update(_scrollable.position, _scrollable.axisDirection);
  }

  @override
  void dispose() {
    _scrollable?.position?.removeListener(notifyListeners);
    super.dispose();
  }
}
