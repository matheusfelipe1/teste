import 'dart:async';

import 'package:flutter/material.dart';

import 'draggable_grid_view_bin.dart';

typedef CreateChild = Widget Function(int position);
typedef EditChangeListener();
typedef DeleteIconClickListener = void Function(int index);

class DragAbleGridView<T extends DragAbleGridViewBin> extends StatefulWidget {
  final CreateChild child;
  final List<T> itemBins;
  List<T> actualItems;

  final int crossAxisCount;

  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;

  final EditSwitchController editSwitchController;

  final EditChangeListener editChangeListener;
  final Function(List<T>) changePositionListener;
  final bool isOpenDragAble;
  final int animationDuration;
  final int longPressDuration;

  Widget deleteIcon;
  final DeleteIconClickListener deleteIconClickListener;

  DragAbleGridView({
    @required this.child,
    @required this.itemBins,
    this.crossAxisCount: 4,
    this.childAspectRatio: 1.0,
    this.mainAxisSpacing: 0.0,
    this.crossAxisSpacing: 0.0,
    this.editSwitchController,
    this.editChangeListener,
    this.changePositionListener,
    this.isOpenDragAble: false,
    this.animationDuration: 300,
    this.longPressDuration: 800,
    this.deleteIcon,
    this.deleteIconClickListener,
  }) : assert(
          child != null,
          itemBins != null,
        );

  @override
  State<StatefulWidget> createState() {
    return new DragAbleGridViewState<T>();
  }
}

class DragAbleGridViewState<T extends DragAbleGridViewBin>
    extends State<DragAbleGridView>
    with SingleTickerProviderStateMixin
    implements DragAbleViewListener {
  var physics = new ScrollPhysics();
  double screenWidth;
  double screenHeight;

  List<int> itemPositions;

  double itemWidth = 0.0;
  double itemHeight = 0.0;
  double itemWidthChild = 0.0;
  double itemHeightChild = 0.0;

  double blankSpaceHorizontal = 0.0;
  double blankSpaceVertical = 0.0;
  double xBlankPlace = 0.0;
  double yBlankPlace = 0.0;

  Animation<double> animation;
  AnimationController controller;
  int startPosition;
  int endPosition;
  bool isRest = false;

  Timer timer;
  bool isRemoveItem = false;
  bool isHideDeleteIcon = true;
  Future _future;
  double xyDistance = 0.0;
  double yDistance = 0.0;
  double xDistance = 0.0;

  @override
  void initState() {
    super.initState();
    widget.editSwitchController.dragAbleGridViewState = this;
    controller = new AnimationController(
        duration: Duration(milliseconds: widget.animationDuration),
        vsync: this);
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        print('object');
        T offsetBin;
        int childWidgetPosition;

        if (isRest) {
          print('is Rest =>>');
          if (startPosition > endPosition) {
            print('startPosition > endPosition =>>');
            for (int i = endPosition; i < startPosition; i++) {
              childWidgetPosition = itemPositions[i];
              offsetBin = widget.itemBins[childWidgetPosition];
              if ((i + 1) % widget.crossAxisCount == 0) {
                offsetBin.lastTimePositionX = -(screenWidth - itemWidth) * 1 +
                    offsetBin.lastTimePositionX;
                offsetBin.lastTimePositionY =
                    (itemHeight + widget.mainAxisSpacing) * 1 +
                        offsetBin.lastTimePositionY;
              } else {
                offsetBin.lastTimePositionX =
                    (itemWidth + widget.crossAxisSpacing) * 1 +
                        offsetBin.lastTimePositionX;
              }
            }
          } else {
            print('start <= end =>>');
            for (int i = startPosition + 1; i <= endPosition; i++) {
              childWidgetPosition = itemPositions[i];
              offsetBin = widget.itemBins[childWidgetPosition];
              if (i % widget.crossAxisCount == 0) {
                offsetBin.lastTimePositionX =
                    (screenWidth - itemWidth) * 1 + offsetBin.lastTimePositionX;
                offsetBin.lastTimePositionY =
                    -(itemHeight + widget.mainAxisSpacing) * 1 +
                        offsetBin.lastTimePositionY;
              } else {
                offsetBin.lastTimePositionX =
                    -(itemWidth + widget.crossAxisSpacing) * 1 +
                        offsetBin.lastTimePositionX;
              }
            }
          }
          return;
        }
        print('is NNOOOOTTT Rest =>>');
        double animationValue = animation.value;

        if (startPosition > endPosition) {
          for (int i = endPosition; i < startPosition; i++) {
            childWidgetPosition = itemPositions[i];
            offsetBin = widget.itemBins[childWidgetPosition];
            if ((i + 1) % widget.crossAxisCount == 0) {
              setState(() {
                offsetBin.dragPointX =
                    -xyDistance * animationValue + offsetBin.lastTimePositionX;
                offsetBin.dragPointY =
                    yDistance * animationValue + offsetBin.lastTimePositionY;
              });
            } else {
              setState(() {
                offsetBin.dragPointX =
                    xDistance * animationValue + offsetBin.lastTimePositionX;
              });
            }
          }
        } else {
          for (int i = startPosition + 1; i <= endPosition; i++) {
            childWidgetPosition = itemPositions[i];
            offsetBin = widget.itemBins[childWidgetPosition];
            if (i % widget.crossAxisCount == 0) {
              setState(() {
                offsetBin.dragPointX =
                    xyDistance * animationValue + offsetBin.lastTimePositionX;
                offsetBin.dragPointY =
                    -yDistance * animationValue + offsetBin.lastTimePositionY;
              });
            } else {
              setState(() {
                offsetBin.dragPointX =
                    -xDistance * animationValue + offsetBin.lastTimePositionX;
              });
            }
          }
        }
      });
    animation.addStatusListener((animationStatus) {
      print('object 40');
      if (animationStatus == AnimationStatus.completed) {
        setState(() {});
        isRest = true;
        controller.reset();
        isRest = false;

        if (isRemoveItem) {
          isRemoveItem = false;
          itemPositions.removeAt(startPosition);
          onPanEndEvent(startPosition);
        } else {
          int dragPosition = itemPositions[startPosition];
          itemPositions.removeAt(startPosition);
          itemPositions.insert(endPosition, dragPosition);
          startPosition = endPosition;
        }
      } else if (animationStatus == AnimationStatus.forward) {}
    });
    _initItemPositions();
  }

  void _initItemPositions() {
    itemPositions = new List();
    for (int i = 0; i < widget.itemBins.length; i++) {
      itemPositions.add(i);
    }
  }

  @override
  void didUpdateWidget(DragAbleGridView<DragAbleGridViewBin> oldWidget) {
    if (itemPositions.length != widget.itemBins.length) {
      _initItemPositions();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Size screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
  }

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
        physics: physics,
        scrollDirection: Axis.vertical,
        itemCount: widget.itemBins.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            childAspectRatio: widget.childAspectRatio,
            crossAxisSpacing: widget.crossAxisSpacing,
            mainAxisSpacing: widget.mainAxisSpacing),
        itemBuilder: (BuildContext contexts, int index) {
          return DragAbleContentView(
            isOpenDragAble: widget.isOpenDragAble,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            isHideDeleteIcon: isHideDeleteIcon,
            controller: controller,
            longPressDuration: widget.longPressDuration,
            index: index,
            dragAbleGridViewBin: widget.itemBins[index],
            dragAbleViewListener: this,
            child: new Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                widget.child(index),
                new Offstage(
                  offstage: isHideDeleteIcon,
                  child: new GestureDetector(
                    child: widget.itemBins[index].data != ''
                        ? widget.deleteIcon
                        : Container(height: 0, width: 0),
                    onTap: () {
                      widget.deleteIconClickListener(index);
                      // Alteração Temporária
                      // setState(() {
                      //   widget.itemBins[index].data = '';
                      // });
                      startPosition = index;
                      endPosition = widget.itemBins.length - 1;
                      getWidgetsSize(widget.itemBins[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void getWidgetsSize(DragAbleGridViewBin pressItemBin) {
    if (itemWidth == 0) {
      itemWidth = pressItemBin.containerKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .width;
    }
    if (itemHeight == 0) {
      itemHeight = pressItemBin.containerKey.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
    }

    if (itemWidthChild == 0) {
      itemWidthChild = pressItemBin.containerKeyChild.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .width;
    }
    if (itemHeightChild == 0) {
      itemHeightChild = pressItemBin.containerKeyChild.currentContext
          .findRenderObject()
          .paintBounds
          .size
          .height;
    }

    if (blankSpaceHorizontal == 0) {
      blankSpaceHorizontal = (itemWidth - itemWidthChild) / 2;
    }

    if (blankSpaceVertical == 0) {
      blankSpaceVertical = (itemHeight - itemHeightChild) / 2;
    }

    if (xBlankPlace == 0) {
      xBlankPlace = blankSpaceHorizontal * 2 + widget.crossAxisSpacing;
    }

    if (yBlankPlace == 0) {
      yBlankPlace = blankSpaceVertical * 2 + widget.mainAxisSpacing;
    }

    if (xyDistance == 0) {
      xyDistance = screenWidth - itemWidth;
    }

    if (yDistance == 0) {
      yDistance = itemHeight + widget.mainAxisSpacing;
    }

    if (xDistance == 0) {
      xDistance = itemWidth + widget.crossAxisSpacing;
    }
  }

  int geyXTransferItemCount(int index, double xBlankPlace, double dragPointX) {
    if (dragPointX.abs() > xBlankPlace) {
      if (dragPointX > 0) {
        return checkXAxleRight(index, xBlankPlace, dragPointX);
      } else {
        return checkXAxleLeft(index, xBlankPlace, dragPointX);
      }
    } else {
      return 0;
    }
  }

  int checkXAxleRight(int index, double xBlankPlace, double dragPointX) {
    double aSection = xBlankPlace + itemWidthChild;

    double rightTransferDistance = dragPointX.abs() + itemWidthChild;
    double rightBorder = rightTransferDistance % aSection;
    double leftBorder = dragPointX.abs() % aSection;

    if (rightBorder < itemWidthChild && leftBorder < itemWidthChild) {
      if (itemWidthChild - leftBorder > rightBorder) {
        return (dragPointX.abs() / aSection).floor();
      } else {
        return (rightTransferDistance / aSection).floor();
      }
    } else if (rightBorder > itemWidthChild && leftBorder < itemWidthChild) {
      return (dragPointX.abs() / aSection).floor();
    } else if (rightBorder < itemWidthChild && leftBorder > itemWidthChild) {
      return (rightTransferDistance / aSection).floor();
    } else {
      return 0;
    }
  }

  int checkXAxleLeft(int index, double xBlankPlace, double dragPointX) {
    double aSection = xBlankPlace + itemWidthChild;

    double leftTransferDistance = dragPointX.abs() + itemWidthChild;

    double leftBorder = leftTransferDistance % aSection;
    double rightBorder = dragPointX.abs() % aSection;

    if (rightBorder < itemWidthChild && leftBorder < itemWidthChild) {
      if (itemWidthChild - rightBorder > leftBorder) {
        return -(dragPointX.abs() / aSection).floor();
      } else {
        return -(leftTransferDistance / aSection).floor();
      }
    } else if (rightBorder > itemWidthChild && leftBorder < itemWidthChild) {
      return -(leftTransferDistance / aSection).floor();
    } else if (rightBorder < itemWidthChild && leftBorder > itemWidthChild) {
      return -(dragPointX.abs() / aSection).floor();
    } else {
      return 0;
    }
  }

  int geyYTransferItemCount(int index, double yBlankPlace, double dragPointY) {
    if (dragPointY.abs() > yBlankPlace) {
      if (dragPointY > 0) {
        return checkYAxleBelow(index, yBlankPlace, dragPointY);
      } else {
        return checkYAxleAbove(index, yBlankPlace, dragPointY);
      }
    } else {
      return index;
    }
  }

  int checkYAxleAbove(int index, double yBlankPlace, double dragPointY) {
    double aSection = yBlankPlace + itemHeightChild;

    double topTransferDistance = dragPointY.abs() + itemHeightChild;

    double topBorder = (topTransferDistance) % aSection;
    double bottomBorder = dragPointY.abs() % aSection;

    if (topBorder < itemHeightChild && bottomBorder < itemHeightChild) {
      if (itemHeightChild - bottomBorder > topBorder) {
        return index -
            (dragPointY.abs() / aSection).floor() * widget.crossAxisCount;
      } else {
        return index -
            (topTransferDistance / aSection).floor() * widget.crossAxisCount;
      }
    } else if (topBorder > itemHeightChild && bottomBorder < itemHeightChild) {
      return index -
          (dragPointY.abs() / aSection).floor() * widget.crossAxisCount;
    } else if (topBorder < itemHeightChild && bottomBorder > itemHeightChild) {
      return index -
          (topTransferDistance / aSection).floor() * widget.crossAxisCount;
    } else {
      return index;
    }
  }

  int checkYAxleBelow(int index, double yBlankPlace, double dragPointY) {
    double aSection = yBlankPlace + itemHeightChild;

    double bottomTransferDistance = dragPointY.abs() + itemHeightChild;

    double bottomBorder = bottomTransferDistance % aSection;
    double topBorder = dragPointY.abs() % aSection;

    if (bottomBorder < itemHeightChild && topBorder < itemHeightChild) {
      if (itemHeightChild - topBorder > bottomBorder) {
        return index +
            (dragPointY.abs() / aSection).floor() * widget.crossAxisCount;
      } else {
        return index +
            (bottomTransferDistance / aSection).floor() * widget.crossAxisCount;
      }
    } else if (topBorder > itemHeightChild && bottomBorder < itemHeightChild) {
      return index +
          (bottomTransferDistance / aSection).floor() * widget.crossAxisCount;
    } else if (topBorder < itemHeightChild && bottomBorder > itemHeightChild) {
      return index +
          (dragPointY.abs() / aSection).floor() * widget.crossAxisCount;
    } else {
      return index;
    }
  }

  @override
  void onFingerPause(int index, double dragPointX, double dragPointY,
      DragUpdateDetails updateDetail) async {
    int y = geyYTransferItemCount(index, yBlankPlace, dragPointY);
    int x = geyXTransferItemCount(index, xBlankPlace, dragPointX);

    if (endPosition != x + y &&
        !controller.isAnimating &&
        x + y < widget.itemBins.length &&
        x + y >= 0 &&
        widget.itemBins[index].dragAble) {
      endPosition = x + y;
      _future = controller.forward();
    }
  }

  @override
  void onPanEndEvent(index) async {
    widget.itemBins[index].dragAble = false;
    if (controller.isAnimating) {
      await _future;
    }
    // Repositioning
    List<T> itemBi = new List();
    T bin;
    for (int i = 0; i < itemPositions.length; i++) {
      bin = widget.itemBins[itemPositions[i]];
      bin.dragPointX = 0.0;
      bin.dragPointY = 0.0;
      bin.lastTimePositionX = 0.0;
      bin.lastTimePositionY = 0.0;
      itemBi.add(bin);
    }

    setState(() {
      widget.itemBins.clear();
      widget.itemBins.addAll(itemBi);
      widget.changePositionListener(widget.itemBins);
      _initItemPositions();
    });
  }

  void changeDeleteIconState() {
    setState(() {
      isHideDeleteIcon = !isHideDeleteIcon;
    });
  }

  @override
  void onTapDown(int index) {
    endPosition = index;
  }

  @override
  double getItemHeight() {
    return itemHeight;
  }

  @override
  double getItemWidth() {
    return itemWidth;
  }

  @override
  void onPressSuccess(int index) {
    setState(() {
      startPosition = index;
      if (widget.editChangeListener != null && isHideDeleteIcon == true) {
        widget.editChangeListener();
      }
      isHideDeleteIcon = false;
    });
  }
}

class EditSwitchController {
  DragAbleGridViewState dragAbleGridViewState;

  void editStateChanged() {
    dragAbleGridViewState.changeDeleteIconState();
  }
}

class DragAbleContentView<T extends DragAbleGridViewBin>
    extends StatefulWidget {
  final Widget child;
  final bool isOpenDragAble;
  final double screenWidth, screenHeight;
  final bool isHideDeleteIcon;
  final AnimationController controller;
  final int longPressDuration;
  final int index;
  final T dragAbleGridViewBin;
  final DragAbleViewListener dragAbleViewListener;

  DragAbleContentView({
    @required this.child,
    @required this.isOpenDragAble,
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.isHideDeleteIcon,
    @required this.controller,
    @required this.longPressDuration,
    @required this.index,
    @required this.dragAbleGridViewBin,
    @required this.dragAbleViewListener,
  });

  @override
  State<StatefulWidget> createState() {
    return DragAbleContentViewState<T>();
  }
}

class DragAbleContentViewState<T extends DragAbleGridViewBin>
    extends State<DragAbleContentView<T>> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: widget.isOpenDragAble
          ? (detail) {
              handleOnTapDownEvent(detail);
            }
          : null,
      onPanUpdate: widget.isOpenDragAble
          ? (updateDetail) {
              handleOnPanUpdateEvent(updateDetail);
            }
          : null,
      onPanEnd: widget.isOpenDragAble
          ? (upDetail) {
              handleOnPanEndEvent(widget.index);
            }
          : null,
      onTapUp: widget.isOpenDragAble
          ? (tapUpDetails) {
              handleOnTapUp();
            }
          : null,
      child: new Offstage(
        offstage: widget.dragAbleGridViewBin.offstage,
        child: new Container(
          alignment: Alignment.center,
          key: widget.dragAbleGridViewBin.containerKey,
          child: new OverflowBox(
              maxWidth: widget.screenWidth,
              maxHeight: widget.screenHeight,
              alignment: Alignment.center,
              child: new Center(
                child: new Container(
                  key: widget.dragAbleGridViewBin.containerKeyChild,
                  transform: new Matrix4.translationValues(
                      widget.dragAbleGridViewBin.dragPointX,
                      widget.dragAbleGridViewBin.dragPointY,
                      0.0),
                  child: widget.child,
                ),
              )),
        ),
      ),
    );
  }

  void handleOnPanEndEvent(int index) {
    print('1');
    T pressItemBin = widget.dragAbleGridViewBin;
    pressItemBin.isLongPress = false;
    if (!pressItemBin.dragAble) {
      pressItemBin.dragPointY = 0.0;
      pressItemBin.dragPointX = 0.0;
    } else {
      widget.dragAbleGridViewBin.dragAble = false;
      widget.dragAbleViewListener.onPanEndEvent(index);
    }
  }

  void handleOnTapUp() {
    print('2');
    T pressItemBin = widget.dragAbleGridViewBin;
    pressItemBin.isLongPress = false;
    if (!widget.isHideDeleteIcon) {
      setState(() {
        pressItemBin.dragPointY = 0.0;
        pressItemBin.dragPointX = 0.0;
      });
    }
  }

  void handleOnPanUpdateEvent(DragUpdateDetails updateDetail) {
    print('3');
    T pressItemBin = widget.dragAbleGridViewBin;
    pressItemBin.isLongPress = false;
    if (pressItemBin.dragAble) {
      double deltaDy = updateDetail.delta.dy;
      double deltaDx = updateDetail.delta.dx;

      double dragPointY = pressItemBin.dragPointY += deltaDy;
      double dragPointX = pressItemBin.dragPointX += deltaDx;

      if (widget.controller.isAnimating) {
        return;
      }
      bool isMove = deltaDy.abs() > 0.0 || deltaDx.abs() > 0.0;

      if (isMove) {
        if (timer != null && timer.isActive) {
          timer.cancel();
        }
        setState(() {});
        timer = new Timer(new Duration(milliseconds: 10), () {
          widget.dragAbleViewListener.onFingerPause(
              widget.index, dragPointX, dragPointY, updateDetail);
        });
      }
    }
  }

  void handleOnTapDownEvent(TapDownDetails detail) {
    print('4');
    T pressItemBin = widget.dragAbleGridViewBin;
    widget.dragAbleViewListener.getWidgetsSize(pressItemBin);

    if (!widget.isHideDeleteIcon) {
      double ss = pressItemBin.containerKey.currentContext
          .findRenderObject()
          .getTransformTo(null)
          .getTranslation()
          .y;
      double aa = pressItemBin.containerKey.currentContext
          .findRenderObject()
          .getTransformTo(null)
          .getTranslation()
          .x;

      double itemHeight = widget.dragAbleViewListener.getItemHeight();
      double itemWidth = widget.dragAbleViewListener.getItemWidth();
      pressItemBin.dragPointY = detail.globalPosition.dy - ss - itemHeight / 2;
      pressItemBin.dragPointX = detail.globalPosition.dx - aa - itemWidth / 2;
    }

    pressItemBin.isLongPress = true;
    pressItemBin.dragAble = false;
    widget.dragAbleViewListener.onTapDown(widget.index);
    _handLongPress();
  }

  void _handLongPress() async {
    print('5');
    if (widget.dragAbleGridViewBin.data != '') {
      await Future.delayed(
          new Duration(milliseconds: widget.longPressDuration));
      if (widget.dragAbleGridViewBin.isLongPress) {
        setState(() {
          widget.dragAbleGridViewBin.dragAble = true;
        });
        widget.dragAbleViewListener.onPressSuccess(widget.index);
      }
    }
  }
}

abstract class DragAbleViewListener<T extends DragAbleGridViewBin> {
  void getWidgetsSize(T pressItemBin);
  void onTapDown(int index);
  void onFingerPause(int index, double dragPointX, double dragPointY,
      DragUpdateDetails updateDetail);
  void onPanEndEvent(int index);
  double getItemHeight();
  double getItemWidth();
  void onPressSuccess(int index);
}
