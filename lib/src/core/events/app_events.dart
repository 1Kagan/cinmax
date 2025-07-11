import 'dart:async';

class AppEvents {
  static final AppEvents _instance = AppEvents._internal();
  factory AppEvents() => _instance;
  AppEvents._internal();

  final StreamController<String> _eventController =
      StreamController<String>.broadcast();

  Stream<String> get eventStream => _eventController.stream;

  void photoUploadSuccess() {
    _eventController.add('photo_upload_success');
  }

  void dispose() {
    _eventController.close();
  }
}
