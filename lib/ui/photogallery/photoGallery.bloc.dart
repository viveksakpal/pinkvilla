import 'dart:async';
import 'package:pinkvilla/repo/photoGalleryApi.dart';
import 'package:pinkvilla/rest/pinkvillaGalleryModel.dart';

class PhotoGalleryBloc {
  final PhotoGalleryAPI _photoAPI;
  List<Nodes> finalResults;

  PhotoGalleryBloc(this._photoAPI) {}

  // ignore: close_sinks
  final _listVideosController = StreamController<List<Nodes>>();

  Stream<List<Nodes>> get listPhotos => _listVideosController.stream;


   initialLoadPhotos() async {
     var results = await _photoAPI.getlistFromPinkvilla(1);
     finalResults = results.data;
     _listVideosController.sink.add(finalResults);
  }

  void getNextList(int i) async {
    var results = await _photoAPI.getlistFromPinkvilla(i);
    finalResults.addAll(results.data);
    _listVideosController.sink.add(finalResults);
  }
}
