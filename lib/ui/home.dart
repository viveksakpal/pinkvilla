import 'package:flutter/material.dart';
import 'package:pinkvilla/ui/widgets/photo_gallery.dart';
import 'package:pinkvilla/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: black,
      body: getBody(),
    );
  }

  Widget getBody() {
    return ImageGalleryPage();
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: appBarColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Shimmer.fromColors(
              baseColor: Colors.pink[700],
              highlightColor: Colors.pink[100],
              child: Text(
              "Pinkvilla",
              style: TextStyle(
                fontFamily: 'Billabong',
                fontSize: 32,
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}
