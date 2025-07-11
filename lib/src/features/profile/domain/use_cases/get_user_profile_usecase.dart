import 'package:flutter_base/src/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_base/src/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository _repository;

  GetUserProfileUseCase(this._repository);

  Future<UserProfile> call() {
    return _repository.getUserProfile();
  }
}
