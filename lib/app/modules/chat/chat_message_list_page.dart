import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:joinder_app/app/modules/chat/chat_controller.dart';

import 'package:joinder_app/app/shared/util/app_colors.dart';
import 'package:joinder_app/app/shared/util/app_utils.dart';

class ChatMessageListPage extends StatefulWidget {
  @override
  _ChatMessageListPageState createState() => _ChatMessageListPageState();
}

class _ChatMessageListPageState extends State<ChatMessageListPage> {
  ChatController _controller;

  @override
  void initState() {
    _controller = Modular.get<ChatController>();
    _controller.observeChats();
    _controller.getChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.purple,
      child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Image.asset(
                    'assets/images/back_white.png',
                    width: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  "Mensagens",
                  style: TextStyle(
                      color: AppColors.white,
                      fontFamily: 'Nunito',
                      fontSize: 20.0),
                ),
                flexibleSpace: Container(
                  decoration: BoxDecoration(gradient: AppColors.chatGradient),
                ),
              ),
              body: Container(
                  color: AppColors.white,
                  child: Observer(
                    builder: (_) {
                      if (!_controller.isLoading) {
                        if (_controller.chats.length > 0) {
                          return ListView.builder(
                              itemCount: _controller.chats.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = _controller.chats[index];
                                final dateChat = item.messages.length == 0 ? item.date : item.messages.last.date;
                                final DateFormat formatter =
                                    DateFormat('HH:mm');
                                DateTime date = DateTime.parse(
                                    dateChat + 'Z');
                                DateTime dateLocal = date.toLocal();
                                return _bindMesssageInfo(
                                    item.profile.photos.length > 0
                                        ? item.profile.photos.first
                                        : AppUtils.getSignImage(item.profile),
                                    true,
                                    item.profile.name,
                                    item.messages.last.type == "message"
                                        ? item.messages.last.value
                                        : item.messages.last.type == "image"
                                            ? "(Foto)"
                                            : "(Sticker)",
                                    formatter.format(dateLocal),
                                    index);
                              });
                        } else {
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'NENHUM CHAT À \n VISTAAA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.mainFontOpacity9,
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Nunito',
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Text(
                                  'Você ainda não tem nenhuma conversa.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 2,
                                    color: AppColors.thirthFont,
                                    fontSize: 14.0,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                              )
                            ],
                          ));
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )))),
    );
  }

  _bindMesssageInfo(String image, bool online, String name, String lastMessage,
      String hour, int index) {
    var imageOnline = online == true
        ? 'assets/images/sticker-online.png'
        : 'assets/images/sticker-offline.png';
    return GestureDetector(
      onTap: () {
        _controller.getChat(_controller.chats[index].id);
      },
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: UniqueKey(),
        onDismissed: (direction) {
          _controller.deleteChat(index);
        },
        background: Container(
          decoration: BoxDecoration(gradient: AppColors.deleteChatGradient),
          child: Align(
            alignment: Alignment(0.9, 0),
            child: Image.asset(
              'assets/images/delete-chat.png',
              width: 18,
            ),
          ),
        ),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.dividerBorderOpacity59))),
            child: Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 45.0,
                      width: 45.0,
                      child: CachedNetworkImage(
                          imageUrl: image,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                                backgroundColor: AppColors.white,
                                maxRadius: 100.0,
                                minRadius: 100.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(500.0),
                                  child: Image(
                                    image: imageProvider,
                                    width: 45.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(AppColors.purple)),
                          errorWidget: (context, url, error) {
                            return Column(
                              children: <Widget>[
                                Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 2,
                      child: Image.asset(
                        imageOnline,
                        width: 12,
                        height: 12,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width - 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              name,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondFont,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 150,
                            child: Text(
                              lastMessage,
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.fontMessageListChat,
                                  fontFamily: 'Nunito'),
                            ),
                          )
                        ],
                      ),
                      Text(hour,
                          style: TextStyle(
                              fontSize: 10.0,
                              color: AppColors.secondFont,
                              fontFamily: 'Nunito'))
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
