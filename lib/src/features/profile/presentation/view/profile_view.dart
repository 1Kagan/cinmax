import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/config/router/app_router_path.dart';
import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_base/src/features/profile/domain/entities/user_profile.dart';
import 'package:flutter_base/src/features/profile/presentation/state/profile_bloc.dart';
import 'package:flutter_base/src/features/profile/presentation/state/profile_event.dart';
import 'package:flutter_base/src/features/profile/presentation/state/profile_state.dart';
import 'package:flutter_base/src/features/profile/presentation/view/profile_movie_detail_view.dart';
import 'package:flutter_base/src/features/profile/presentation/widgets/limited_offer_bottom_sheet.dart';
import 'package:flutter_base/src/features/profile/presentation/widgets/profile_drawer.dart';
import 'package:flutter_base/src/core/events/app_events.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  final bool? shouldRefresh;

  const ProfileView({super.key, this.shouldRefresh});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late ProfileBloc _profileBloc;
  StreamSubscription? _eventSubscription;

  @override
  void initState() {
    super.initState();
    _profileBloc = injector<ProfileBloc>();
    _profileBloc.add(ProfileDataFetched());

    // Upload success event'ini dinle
    _eventSubscription = AppEvents().eventStream.listen((event) {
      if (event == 'photo_upload_success' && mounted) {
        print('🔄 Photo upload success event received, refreshing profile');
        _profileBloc.add(ProfileDataFetched());
      }
    });
  }

  @override
  void dispose() {
    _eventSubscription?.cancel();
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider.value(
      value: _profileBloc,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const ProfileDrawer(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: _buildAppBar(context, scaffoldKey),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading &&
                state.userProfile == null) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.status == ProfileStatus.failure) {
              return Center(
                  child: Text(
                      state.errorMessage ?? context.l10n.translate('error')));
            }
            if (state.userProfile == null) {
              return Center(
                  child: Text(context.l10n.translate('no_user_data')));
            }
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.menu,
                    color: Theme.of(context).colorScheme.onSurface, size: 22),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
            ),
          ),
        ),
      ),
      title: Text(
        context.l10n.translate('profile_detail'),
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: FilledButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return const LimitedOfferBottomSheet();
                },
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColorTheme.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.diamond_outlined, size: 16),
                const SizedBox(width: 8),
                Text(
                  context.l10n.translate('limited_offer'),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, ProfileState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50.h),
          _ProfileHeader(userProfile: state.userProfile!),
          SizedBox(height: 24.h),
          Text(
            context.l10n.translate('my_favorite_movies'),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: _FavoriteMoviesGrid(movies: state.favoriteMovies),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserProfile userProfile;
  const _ProfileHeader({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final displayId = userProfile.id.length > 6
        ? userProfile.id.substring(0, 6)
        : userProfile.id;

    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor:
              userProfile.photoUrl == null || userProfile.photoUrl!.isEmpty
                  ? Theme.of(context).colorScheme.surface
                  : null,
          backgroundImage:
              userProfile.photoUrl != null && userProfile.photoUrl!.isNotEmpty
                  ? CachedNetworkImageProvider(userProfile.photoUrl!)
                  : null,
          child: userProfile.photoUrl == null || userProfile.photoUrl!.isEmpty
              ? Icon(Icons.person,
                  size: 30, color: Theme.of(context).colorScheme.onSurface)
              : null,
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userProfile.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              '${context.l10n.translate('user_id')}: $displayId',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            context.router.pushNamed(RouterPath.uploadPhoto);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColorTheme.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            context.l10n.translate('add_photo'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _FavoriteMoviesGrid extends StatelessWidget {
  final List<FavoriteMovie> movies;
  const _FavoriteMoviesGrid({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        final heroTag = 'profile_movie_${movie.id}';
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProfileMovieDetailView(
                  movie: movie,
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: movie.posterUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                movie.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                movie.plot,
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
