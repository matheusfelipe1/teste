import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:uuid/uuid.dart';

import 'draggable_grid_view.dart';
import 'itemBin.dart';

class DragAbleGridViewComponent extends StatefulWidget {
  final List _photos;
  final Function(List<String>) _onChanged;

  DragAbleGridViewComponent(
      {Key key, List photos, Function(List<String>) onChanged})
      : _photos = photos,
        _onChanged = onChanged,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DragAbleGridViewComponentState();
  }
}

int count = 0;

class DragAbleGridViewComponentState extends State<DragAbleGridViewComponent> {
  List get _photos => widget._photos;
  Function(List<String>) get _onChanged => widget._onChanged;
  List<ItemBin> itemBins = new List();
  List<String> cancelledItems = new List();
  EditSwitchController editSwitchController = EditSwitchController();

  @override
  void initState() {
    super.initState();
    _photos.forEach((img) {
      itemBins.add(new ItemBin(img));
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragAbleGridView(
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
      childAspectRatio: 1,
      crossAxisCount: 4,
      itemBins: itemBins,
      editSwitchController: editSwitchController,
      isOpenDragAble: true,
      animationDuration: 10,
      longPressDuration: 10,
      deleteIcon: Image.asset(
        "assets/images/close.png",
        width: 20.0,
        height: 20.0,
      ),
      child: (int position) {
        return GestureDetector(
          child: Container(
              height: MediaQuery.of(context).size.width * 0.18,
              width: MediaQuery.of(context).size.width * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                border: Border.all(color: AppColors.mainBorder),
              ),
              child: itemBins[position].data != ''
                  ? itemBins[position].data.contains('loading')
                      ? Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(AppColors.purple)),
                        )
                      : itemBins[position].data.contains('error')
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            )
                          : CachedNetworkImage(
                              imageUrl: itemBins[position].data,
                              fit: BoxFit.cover,
                              imageBuilder: (context, imageProvider) => Image(
                                    image: imageProvider,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    fit: BoxFit.cover,
                                  ),
                              placeholder: (context, url) => Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            AppColors.purple)),
                                  ),
                              errorWidget: (context, url, error) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 30.0,
                                      ),
                                    ),
                                  ],
                                );
                              })
                  : Material(
                      child: IconButton(
                          icon: Image.asset(
                            'assets/images/plus-circle-icon.png',
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                    "Você pode tirar uma foto ou escolher do seu celular",
                                    style: TextStyle(
                                      color: AppColors.secondFont,
                                      fontSize: 13.0,
                                      fontFamily: 'Nunito',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  content: Container(
                                    height: 100,
                                    margin: EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            getImage(ImageSource.camera);
                                          },
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                    'assets/images/camera.png',
                                                    height: 35),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Text(
                                                    'TIRAR FOTO\nAGORA',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.secondFont,
                                                      fontSize: 10.0,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontFamily: 'Nunito',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              getImage(ImageSource.gallery);
                                            },
                                            child: Container(
                                              child: Column(
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/gallery.png',
                                                    height: 35,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10.0),
                                                    child: Text(
                                                      'SELECIONAR\nDA GALERIA',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondFont,
                                                        fontSize: 10.0,
                                                        fontFamily: 'Nunito',
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }))),
        );
      },
      editChangeListener: () {
        changeActionState();
      },
      changePositionListener: (list) {
        // Verificar se o último é o botão +
        var findPlus = itemBins.where((e) => e.data == "").first;
        var indexPlus = itemBins.indexOf(findPlus);
        if (indexPlus != itemBins.length - 1) {
          setState(() {
            itemBins.add(findPlus);
            itemBins.removeAt(indexPlus);
          });
        }
        List<String> photos = new List<String>();
        itemBins.forEach((element) {
          if (!element.data.contains('loading') &&
              !element.data.contains('error') &&
              element.data != "") {
            photos.add(element.data);
          }
        });
        _onChanged(photos);
      },
      deleteIconClickListener: (val) {
        if (itemBins[val] != null) {
          setState(() {
            itemBins.removeAt(val);
            if (itemBins.where((e) => e.data == '').length == 0 &&
                itemBins.length < 8) itemBins.add(new ItemBin(''));
          });
          if (itemBins[val].data.contains('loading')) {
            cancelledItems.add(itemBins[val].data);
          }
          List<String> photos = new List<String>();
          itemBins.forEach((element) {
            if (!element.data.contains('loading') &&
                !element.data.contains('error') &&
                element.data != "") {
              photos.add(element.data);
            }
          });
          _onChanged(photos);
        }
      },
    );
  }

  void changeActionState() {
    print(itemBins);
  }

  getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    var lengthImage = image.lengthSync();
    if (image != null) {
      if (lengthImage <= 1000000) {
        String identifier = 'loading${Uuid().v1()}';
        setState(() {
          itemBins.last = new ItemBin(identifier);
          if (itemBins.length < 8) itemBins.add(new ItemBin(''));
        });
        final resultMap = await uploadImage(image, identifier);
        if (cancelledItems
                .where((element) => element == resultMap["identifier"])
                .length ==
            0) {
          if (itemBins
                  .where((element) => element.data == resultMap["identifier"])
                  .first !=
              null)
            setState(() {
              itemBins
                  .where((element) => element.data == resultMap["identifier"])
                  .first
                  .data = resultMap["image"];
            });
        }
        List<String> photos = new List<String>();
        itemBins.forEach((element) {
          if (!element.data.contains('loading') &&
              !element.data.contains('error') &&
              element.data != "") {
            photos.add(element.data);
          }
        });
        _onChanged(photos);
      }
    }
  }

  Future<Map<String, String>> uploadImage(File file, String identifier) async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        String uidImg = Uuid().v1();
        final storageReference = FirebaseStorage.instance.ref();
        final referenceKey = "User";
        final node = storageReference.child(referenceKey).child('$uidImg');
        StorageUploadTask uploadTask = node.putFile(file);
        await uploadTask.onComplete;
        final result = await node.getDownloadURL();
        Map<String, String> map = new Map<String, String>();
        map["identifier"] = identifier;
        map["image"] = result;
        return map;
      } else {
        Map<String, String> map = new Map<String, String>();
        map["identifier"] = identifier;
        final value = identifier.replaceFirst("loading", "error");
        map["image"] = value;
        return map;
      }
    } catch (e) {
      Map<String, String> map = new Map<String, String>();
      map["identifier"] = identifier;
      final value = identifier.replaceFirst("loading", "error");
      map["image"] = value;
      return map;
    }
  }
}
