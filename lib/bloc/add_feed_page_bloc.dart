import 'dart:io';

import 'package:fire_base/bloc/base_bloc.dart';
import 'package:fire_base/utils/enums.dart';
import 'package:fire_base/utils/file_upload_to_fire_base_utils.dart';

class AddFeedPageBloc extends BaseBloc {
  FileType _fileType = FileType.photo;
  File? _selectFile;

  File? get getSelectFile => _selectFile;
  FileType get getFileType => _fileType;

  Future uploadFileToFirebaseStorage() {
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
