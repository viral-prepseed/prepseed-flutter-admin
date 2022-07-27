import '../../model/announcement_model/announcement_model.dart';
import '../../model/playlist_model/assignment_model/assignment_model.dart';
import '../../model/playlist_model/video_model/comment/comment_model.dart';
import '../../model/playlist_model/playlists.dart';
import '../../model/playlist_model/video_model/comment/post_comment.dart';
import '../../model/playlist_model/document_model/resource_document_model.dart';
import '../../model/playlist_model/assignment_model/upload_assi_model.dart';
import '../../model/playlist_model/video_model/videoPlaylistModel.dart';
import '../../repository/playlist_repo/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../announcement_repo/announcement_repo.dart';
import '../playlist_repo/assignment_repo/assignment_repo.dart';
import '../playlist_repo/assignment_repo/upload_assi_repo.dart';
import '../playlist_repo/document_repo/document_repo.dart';
import '../playlist_repo/video_repo/comment_repo/getcomment_repo.dart';
import '../playlist_repo/video_repo/comment_repo/post_comment_repo.dart';
import '../playlist_repo/video_repo/video_repo.dart';

class VideosProvider extends ChangeNotifier {
  bool disposed = false;

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }
  Provider prov = Provider();

  playlist_model data = playlist_model();

  getVideos() async {
    data = await prov.getPlaylist();
    calTag();
    getAnnouncement();
    notifyListeners();
  }

  List tagValue = [];
  List tagValueDoc = [];
  List tagValueAssi = [];
  List tagVideo = [];
  List tagDoc = [];
  List str = [];
  List strDoc= [];
  List strAssi = [];
  calTag(){
    data.playlists!.forEach((element) {
      if(element.resourceType == "Video"){
        if(element.tags!.length != 0){
        tagValue.add(element);}
      else{
        tagValue.add(element.title);
      }
      }
      else if(element.resourceType == "ResourceDocument"){
        if(element.tags!.length != 0){
          tagValueDoc.add(element);}
        else{
          tagValueDoc.add(element.title);
        }
      }
      else{
        if(element.tags!.length != 0){
          tagValueAssi.add(element);}
        else{
          tagValueAssi.add(element.title);
        }
      }
    });

    tagValue.forEach((elementTag) {
      //str.add(elementTag.tags![0].value);
      if(elementTag.runtimeType == String){
        str.add(elementTag);
      }
      else{
        str.add(elementTag.tags![0].value);
      }

    });
    tagValueDoc.forEach((elementTag) {
      //strDoc.add(elementTag.tags![0].value);
      if(elementTag.runtimeType == String){
        strDoc.add(elementTag);
      }
      else{
        strDoc.add(elementTag.tags![0].value);
      }
    });
    tagValueAssi.forEach((elementTag) {
      //strAssi.add(elementTag.tags![0].value);
      if(elementTag.runtimeType == String){
        strAssi.add(elementTag);
      }
      else{
        strAssi.add(elementTag.tags![0].value);
      }
    });
    str = str.toSet().toList();
    strDoc = strDoc.toSet().toList();
    strAssi = strAssi.toSet().toList();
    calTagData();
  }

  Map<dynamic,dynamic> map ={};
  Map<dynamic,dynamic> mapDoc ={};
  Map<dynamic,dynamic> mapAssi ={};
  calTagData(){
    str.forEach((element) {
      List playList = [];
      data.playlists!.forEach((playlistElement) {
        if(playlistElement.tags!.length != 0){
        if(element == playlistElement.tags![0].value){
          if(playlistElement.resourceType == "Video"){
          playList.add(playlistElement);}
        }}
        else{
          if(playlistElement.resourceType == "Video"){
            playList.add(playlistElement);}
        }
      });
      map[element] = playList;
    });
    strDoc.forEach((element) {
      List playList = [];
      data.playlists!.forEach((playlistElement) {
        if(playlistElement.tags!.length != 0){
        if(element == playlistElement.tags![0].value){
          if(playlistElement.resourceType == "ResourceDocument"){
          playList.add(playlistElement);
          }
        }}
        else{
          if(playlistElement.resourceType == "ResourceDocument"){
            playList.add(playlistElement);
          }
        }
      });
      mapDoc[element] = playList;
    });
    strAssi.forEach((element) {
      List playList = [];
      data.playlists!.forEach((playlistElement) {
        if(playlistElement.tags!.length != 0){
          if(element == playlistElement.tags![0].value){
            if(playlistElement.resourceType == "Assignment"){
              playList.add(playlistElement);
            }
          }}
        else{
          if(playlistElement.resourceType == "Assignment"){
            playList.add(playlistElement);
          }
        }
      });
      mapAssi[element] = playList;
    });
  }

  VideoPlaylistModel list = VideoPlaylistModel();

  VideoRepo videoRepo = VideoRepo();
  getVideoPlaylist(String id) async {
    list = await videoRepo.getVideoPlaylist(id);
    print(list);
    notifyListeners();
  }

  CommentModel comment = CommentModel();
  CommentRepo commentRepo = CommentRepo();
  getComment(String id) async{
    comment = await commentRepo.getComment(id);
   // print(comment);
    notifyListeners();
  }

  PostComment post = PostComment();
  PostCommentRepo postCommentRepo = PostCommentRepo();
  postComment(String title, String id) async{
    post = await postCommentRepo.uploadComment(title, id);
    //print(post);
  }

  ResourceDocumentsModel doc = ResourceDocumentsModel();
  DocumentRepo documentRepo = DocumentRepo();
  getResourceDocuments(String id) async {
    doc = await documentRepo.getResourceDocuments(id);
   // print(doc);
    notifyListeners();
  }

  AssignmentModel assignmentModel = AssignmentModel();
  AssignmentRepo assignmentRepo = AssignmentRepo();
  getAssignments(String id) async {
    assignmentModel = await assignmentRepo.getAssignments(id);
    notifyListeners();
    /*print(assignmentModel);*/
  }


  TextEditingController controller = TextEditingController();
  String searchingText = "";
  bool? isSearching;


  searchTextVideo(controller) {
    List _searchList = [];
    if (controller.text.isEmpty) {
      //isSearching =  false;
      searchingText =  "";
    }
    else {
      //isSearching = true;
      searchingText = controller.text;
    }
    List tagList = [];
    List _tagList = [];
    Map<dynamic,dynamic> mapList ={};
    tagValue.forEach((element) {
      if (element.tags[0].value.toString().toLowerCase().contains(searchingText.toLowerCase())) {
        _searchList.add(element);
        tagList.add(element.tags[0].value);
        _tagList = tagList.toSet().toList();
      }
    });
    _tagList.forEach((element) {
      List playList = [];
      _searchList.forEach((playlistElement) {
        if(element == playlistElement.tags![0].value){
          playList.add(playlistElement);}
      });
      mapList[element] = playList;
    });

    str = _tagList;
    map = mapList;
    notifyListeners();
  }

  searchTextDoc(controller) async {
    List _searchList = [];
    if (controller.text.isEmpty) {
      isSearching =  false;
      searchingText =  "";
    }
    else {
      isSearching = true;
      searchingText = controller.text;
    }
    List tagList = [];
    List _tagList = [];
    Map<dynamic,dynamic> mapList ={};
    tagValueDoc.forEach((element) {
      if (element.tags[0].value.toString().toLowerCase().contains(searchingText.toLowerCase())) {
        _searchList.add(element);
        tagList.add(element.tags[0].value);
        _tagList = tagList.toSet().toList();
      }
    });
    _tagList.forEach((element) {
      List playList = [];
      _searchList.forEach((playlistElement) {
        if(element == playlistElement.tags![0].value){
          playList.add(playlistElement);}
      });
      mapList[element] = playList;
    });

    strDoc = _tagList;
    mapDoc = mapList;
    notifyListeners();
  }

  UploadAssignmentModel uploadAssignmentModel = UploadAssignmentModel();
  UploadAssignmentRepo uploadAssignmentRepo = UploadAssignmentRepo();
  uploadAssignment(var filename, String mime) async {
    uploadAssignmentModel = await uploadAssignmentRepo.assignmentUpload(filename.name, mime);
    String url = uploadAssignmentModel.data!.url.toString();
    var urls = Uri.parse(url);
    var request = http.MultipartRequest('POST',urls);
    request.files.add(await http.MultipartFile.fromPath('file', filename.path));
    request.fields.addAll({'key':uploadAssignmentModel.data!.fields!.key.toString() , 'acl':uploadAssignmentModel.data!.fields!.acl.toString()});
    await request.send();
    //SimpleS3 simpleS3 = SimpleS3();
    //Future<String> result = simpleS3.uploadFile(filename, uploadAssignmentModel.data!.fields!.bucket!,"",uploadAssignmentModel.data!.fields!);
    notifyListeners();
  }

  AnnouncementRepo announcementRepo = AnnouncementRepo();
  AnnouncementModel announcementModel = AnnouncementModel();
  getAnnouncement() async {
    announcementModel = await announcementRepo.getAnnouncements();
    print(announcementModel);
    notifyListeners();
  }
}
