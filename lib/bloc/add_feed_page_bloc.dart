import 'dart:io';

import 'package:fire_base/bloc/base_bloc.dart';
import 'package:fire_base/data/model/feed_model.dart';
import 'package:fire_base/data/vos/feed_vo.dart';
import 'package:fire_base/utils/enums.dart';
import 'package:fire_base/utils/file_upload_to_fire_base_utils.dart';

class AddFeedPageBloc extends BaseBloc {
  FileType _fileType = FileType.photo;
  File? _selectFile;

  File? get getSelectFile => _selectFile;

  FileType get getFileType => _fileType;
  final FeedModel _feedModel = FeedModel();

  FileType _getFileTypeFromString(String fileType) {
    if (fileType == FileType.photo.name) {
      return FileType.photo;
    } else if (fileType == FileType.video.name) {
      return FileType.video;
    }
    return FileType.file;
  }

  Future saveFeed(String description) async {
    if (description.isEmpty) {
      return Future.error("Please write what is in your mind");
    }
    int id = DateTime.now().millisecondsSinceEpoch;

    String fileURL = await _uploadFileToFirebaseStorage();

    final feed = FeedVO(id: id, feedTitle: description, fileURL: fileURL, fileType: _fileType.name, createdAt: DateTime.now().toString());
    return _feedModel.saveFeed(feed);
  }

  Future _uploadFileToFirebaseStorage() {
    String path = '';
    if (_fileType == FileType.photo) {
      path = 'image';
    } else if (_fileType == FileType.video) {
      path = 'video';
    } else {
      path = 'file';
    }
    if (_selectFile == null) {
      return Future.error('Please select File');
    }
    return FileUploadToFireBaseUtils.uploadToFirebaseStorage(_selectFile!, path);
  }

  set setFileType(FileType fileType) {
    _fileType = fileType;
    notifyListeners();
  }

  set setSelectFile(File? file) {
    _selectFile = file;
    notifyListeners();
  }
}
