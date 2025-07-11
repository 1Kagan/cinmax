import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UploadPhotoEvent extends Equatable {
  const UploadPhotoEvent();

  @override
  List<Object?> get props => [];
}

class PhotoSelected extends UploadPhotoEvent {
  final File file;

  const PhotoSelected(this.file);

  @override
  List<Object?> get props => [file];
}

class UploadSubmitted extends UploadPhotoEvent {}
