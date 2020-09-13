import 'dart:convert';
import 'package:pinkvilla/rest/networkHelper.dart';
import 'package:pinkvilla/rest/networkResult.dart';
import '../rest/pinkvillaGalleryModel.dart';

class PhotoGalleryAPI {
  PhotoGalleryAPI();
  Future<NetworkResult<List<Nodes>>>
      getlistFromPinkvilla(int pageCount) async {
    NetworkHelper networkHelper = NetworkHelper();

    final response = await networkHelper
        .get<String>('http://www.pinkvilla.com/photo-gallery-feed-page/page/' + pageCount.toString());
    return NetworkResult<List<Nodes>>.handleRes(response,
        (String result) {
      final data = json.decode(result);
      final dataAsList = data["nodes"] as List;

      return PinkvillaGalleryModel.listFrmJson(dataAsList);
    });
  }

  // loadVideos() async {
  //  await getlistFromPinkvilla();
  //   //listVideosEvent.add(_videoList);
  // }
}
