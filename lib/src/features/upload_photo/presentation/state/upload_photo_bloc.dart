import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_base/src/features/upload_photo/domain/use_cases/upload_photo_usecase.dart';
import 'package:flutter_base/src/features/upload_photo/presentation/state/upload_photo_event.dart';
import 'package:flutter_base/src/features/upload_photo/presentation/state/upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadPhotoUseCase _uploadPhotoUseCase;

  UploadPhotoBloc(this._uploadPhotoUseCase) : super(const UploadPhotoState()) {
    on<PhotoSelected>(_onPhotoSelected);
    on<UploadSubmitted>(_onUploadSubmitted);
  }

  void _onPhotoSelected(PhotoSelected event, Emitter<UploadPhotoState> emit) {
    print('🔄 PhotoSelected event received');
    print('📁 File path: ${event.file.path}');
    emit(state.copyWith(selectedFile: event.file));
    print('✅ State updated with selected file');
  }

  Future<void> _onUploadSubmitted(
    UploadSubmitted event,
    Emitter<UploadPhotoState> emit,
  ) async {
    print('⬆️ UploadSubmitted event received');
    print('📄 Selected file: ${state.selectedFile?.path}');

    if (state.selectedFile == null) {
      print('❌ No file selected, returning');
      return;
    }

    print('🔄 Starting upload...');
    emit(state.copyWith(status: SubmissionStatus.loading));

    try {
      await _uploadPhotoUseCase(state.selectedFile!);
      print('✅ Upload successful');
      emit(state.copyWith(status: SubmissionStatus.success));
    } catch (e) {
      print('❌ Upload failed: $e');
      emit(state.copyWith(
        status: SubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
