import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/core/events/app_events.dart';
import 'package:flutter_base/src/features/upload_photo/presentation/state/upload_photo_bloc.dart';
import 'package:flutter_base/src/features/upload_photo/presentation/state/upload_photo_event.dart';
import 'package:flutter_base/src/features/upload_photo/presentation/state/upload_photo_state.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class UploadPhotoView extends StatefulWidget {
  const UploadPhotoView({super.key});

  @override
  State<UploadPhotoView> createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  late UploadPhotoBloc _uploadPhotoBloc;

  @override
  void initState() {
    super.initState();
    _uploadPhotoBloc = injector<UploadPhotoBloc>();
    _requestPermissions();
  }

  @override
  void dispose() {
    _uploadPhotoBloc.close();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      await Permission.camera.request();

      final photosStatus = await Permission.photos.request();
      if (photosStatus.isDenied) {
        await Permission.storage.request();
      }
    } catch (e) {
      debugPrint('Permission request error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _uploadPhotoBloc,
      child: BlocListener<UploadPhotoBloc, UploadPhotoState>(
        listener: (context, state) {
          print('👂 BlocListener received state change: ${state.status}');
          print('👂 BlocListener state: $state');
          if (state.status == SubmissionStatus.success) {
            _showSuccessSheet(context);
          } else if (state.status == SubmissionStatus.failure) {
            _showErrorSheet(context, state.errorMessage);
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
          bottomNavigationBar: _buildBottomButton(context),
        ),
      ),
    );
  }

  void _showSuccessSheet(BuildContext context) {
    context.showContentBottomSheet(
      title: context.l10n.translate('success'),
      buttonLabel: context.l10n.translate('ok'),
      useButton: true,
      onCloseButtonTap: (c) => _navigateToProfileWithRefresh(c),
      onButtonTap: (c) => _navigateToProfileWithRefresh(c),
      content: Column(
        children: [
          Text(context.l10n.translate('photo_uploaded_successfully')),
        ],
      ),
      context: context,
    );
  }

  void _navigateToProfileWithRefresh(BuildContext context) {
    // Önce modal'ı kapat
    Navigator.of(context).pop();

    // Global event yayınla ki ProfileView refresh yapsın
    AppEvents().photoUploadSuccess();
    print('📤 Photo upload success event sent, going back');

    // Ana sayfaya dön
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        this.context.router.pop();
      }
    });
  }

  void _showErrorSheet(BuildContext context, String? message) {
    context.showContentBottomSheet(
      title: context.l10n.translate('upload_failed'),
      buttonLabel: context.l10n.translate('close'),
      useButton: true,
      onCloseButtonTap: (c) => Navigator.of(c).pop(),
      onButtonTap: (c) => Navigator.of(c).pop(),
      content: Column(
        children: [
          Text(message ?? context.l10n.translate('unknown_error')),
        ],
      ),
      context: context,
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                context.l10n.translate('select_image_source'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(context.l10n.translate('camera')),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(context.l10n.translate('gallery')),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  _pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      bool hasPermission = false;

      if (source == ImageSource.camera) {
        final status = await Permission.camera.status;
        if (status.isDenied || status.isPermanentlyDenied) {
          _showPermissionDeniedDialog(context, 'camera');
          return;
        }
        hasPermission = status.isGranted;
      } else {
        final photosStatus = await Permission.photos.status;
        final storageStatus = await Permission.storage.status;
        hasPermission = photosStatus.isGranted || storageStatus.isGranted;

        if (!hasPermission) {
          _showPermissionDeniedDialog(context, 'gallery');
          return;
        }
      }

      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 80,
      );

      if (image != null) {
        final file = File(image.path);
        print('📷 Image selected: ${file.path}');
        print('📷 File exists: ${file.existsSync()}');
        print('📷 File size: ${file.lengthSync()} bytes');

        if (mounted) {
          print('📷 Widget is mounted, adding event to bloc...');
          print('📷 Bloc: $_uploadPhotoBloc');
          print('📷 Adding PhotoSelected event to bloc');
          _uploadPhotoBloc.add(PhotoSelected(file));
          print('📷 PhotoSelected event added');
        } else {
          print('❌ Widget not mounted');
        }
      } else {
        print('❌ No image selected');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSheet(context, 'Failed to pick image: ${e.toString()}');
      }
    }
  }

  void _showPermissionDeniedDialog(BuildContext context, String source) {
    context.showContentBottomSheet(
      title: context.l10n.translate('permission_denied'),
      content: Column(
        children: [
          Text(
            source == 'camera'
                ? context.l10n.translate('camera_permission_message')
                : context.l10n.translate('gallery_permission_message'),
          ),
        ],
      ),
      buttonLabel: context.l10n.translate('settings'),
      onButtonTap: (c) {
        Navigator.of(c).pop();
        openAppSettings();
      },
      context: context,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        context.l10n.translate('profile_detail'),
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.arrow_back,
                    color: theme.colorScheme.onSurface, size: 22),
                onPressed: () => context.router.pop(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Text(
            context.l10n.translate('upload_your_photos'),
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600, // SemiBold
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            context.l10n.translate('upload_photos_subtitle'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w400, // Regular
            ),
          ),
          SizedBox(height: 80.h),
          _buildImagePicker(context),
        ],
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _showImageSourceDialog(context),
      child: BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
        builder: (context, state) {
          print('🖼️ === IMAGE PICKER REBUILD ===');
          print('🖼️ Building image picker - Status: ${state.status}');
          print(
              '🖼️ Building image picker - Selected file: ${state.selectedFile?.path}');
          print('🖼️ Building image picker - State: $state');
          return Container(
            width: 170.w,
            height: 170.w,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: theme.colorScheme.onSurface.withOpacity(0.2),
                width: 1,
              ),
              image: state.selectedFile != null
                  ? DecorationImage(
                      image: FileImage(state.selectedFile!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: state.selectedFile == null
                ? Center(
                    child: Icon(
                      Icons.add,
                      color: theme.colorScheme.onSurface,
                      size: 26,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return BlocBuilder<UploadPhotoBloc, UploadPhotoState>(
      builder: (context, state) {
        print('⬇️ === BOTTOM BUTTON REBUILD ===');
        print('⬇️ Building bottom button - Status: ${state.status}');
        print('⬇️ Building bottom button - File: ${state.selectedFile?.path}');
        print('⬇️ Building bottom button - State: $state');
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: PrimaryButton(
            text: context.l10n.translate('continueButton'),
            isLoading: state.status == SubmissionStatus.loading,
            onTap: () {
              if (state.selectedFile == null) {
                context.showContentBottomSheet(
                  title: context.l10n.translate('warning'),
                  content: Text(context.l10n.translate('please_select_photo')),
                  buttonLabel: context.l10n.translate('close'),
                  onButtonTap: (c) => Navigator.of(c).pop(),
                  context: context,
                );
              } else {
                context.read<UploadPhotoBloc>().add(UploadSubmitted());
              }
            },
          ),
        );
      },
    );
  }
}
