import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joinder_app/app/shared/util/app_colors.dart';

class MediaPage extends StatelessWidget {
  final String image;

  MediaPage({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagem"),
      ),
      body: SafeArea(
        child: Container(
          child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fitWidth,
                  ),
              placeholder: (context, url) => CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(AppColors.purple)),
              errorWidget: (context, url, error) {
                return Column(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
