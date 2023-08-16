import 'dart:io';

import 'package:fire_base/bloc/base_bloc.dart';
import 'package:fire_base/utils/enums.dart';

class AddFeedPageBloc extends BaseBloc {
  FileType _fileType = FileType.photo;
  File? _selectFile;

  File? get getSelectFile => _selectFile;
  FileType get getFileType => _fileType;

  set setFileType(FileType fileType) {
    _fileType = fileType;
    notifyListeners();
  }

  set setSelectFile(File? file) {
    _selectFile = file;
    notifyListeners();
  }
}
