import 'dart:io';
import 'package:equatable/equatable.dart';

enum SubmissionStatus { initial, loading, success, failure }

class UploadPhotoState extends Equatable {
  final File? selectedFile;
  final SubmissionStatus status;
  final String? errorMessage;

  const UploadPhotoState({
    this.selectedFile,
    this.status = SubmissionStatus.initial,
    this.errorMessage,
  });

  UploadPhotoState copyWith({
    File? selectedFile,
    SubmissionStatus? status,
    String? errorMessage,
  }) {
    return UploadPhotoState(
      selectedFile: selectedFile ?? this.selectedFile,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [selectedFile, status, errorMessage];

  @override
  String toString() {
    return 'UploadPhotoState(selectedFile: ${selectedFile?.path}, status: $status, errorMessage: $errorMessage)';
  }
}
