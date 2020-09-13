import 'package:flutter/material.dart';
import 'package:pinkvilla/rest/mock/search_json.dart';
import 'package:pinkvilla/repo/photoGalleryApi.dart';
import 'package:pinkvilla/rest/pinkvillaGalleryModel.dart';
import 'package:pinkvilla/ui/photogallery/photoGallery.bloc.dart';
import 'package:pinkvilla/ui/widgets/search_cato_item.dart';
import 'package:pinkvilla/utils/colors.dart';

class ImageGalleryPage extends StatefulWidget {
  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  final scrollController = ScrollController();

  int endOfListCounter = 1;
  PhotoGalleryBloc mPhotoBloc;

  @override
  void initState() {
    super.initState();
    mPhotoBloc = PhotoGalleryBloc(PhotoGalleryAPI());
    mPhotoBloc.initialLoadPhotos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<List<Nodes>>(
        stream: mPhotoBloc.listPhotos,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                _buildStaticHomeWidget(size),
                CircularProgressIndicator()
              ],
            );
          } else {
            return Column(
              children: [
                _buildStaticHomeWidget(size),
                Flexible(
                  child: NotificationListener<ScrollNotification>(
                      onNotification: _handleScrollNotification,
                      child: _buildDynamicPhotoGrid(snapshot)),
                ),
              ],
            );
          }
        });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      print("End of List");
      mPhotoBloc.getNextList(endOfListCounter++);
    }

    return false;
  }

  Widget _buildDynamicPhotoGrid(AsyncSnapshot<dynamic> snapshot) {
    List<Nodes> results = snapshot.data;

    return GridView.count(
      physics: ClampingScrollPhysics(),
      crossAxisCount: 3,
      children: List.generate(results.length, (index) {
        return index >= results.length
            ? _buildLoaderListItem()
            : _buildDataListItem(results, index);
      }),
    );
  }

  Widget _buildStaticHomeWidget(var size) {
    return Column(children: <Widget>[
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 13.0),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15,
              ),
              Container(
                width: size.width - 30,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: textFieldBackground),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: white.withOpacity(0.3),
                      )),
                  style: TextStyle(color: Colors.white),
                  cursorColor: white.withOpacity(0.3),
                ),
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 15,
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
              children: List.generate(searchCategories.length, (index) {
            return CategoryStoryItem(
              name: searchCategories[index],
            );
          })),
        ),
      ),
      SizedBox(
        height: 15,
      )
    ]);
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildDataListItem(List<Nodes> data, int index) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://www.pinkvilla.com/" +
                  data[index].node.fieldPhotoImageSection),
              fit: BoxFit.cover)),
    );
  }
}
