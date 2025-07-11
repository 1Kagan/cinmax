import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/home_page/presentation/view/full_screen_image_view.dart';
import 'package:flutter_base/src/features/profile/domain/entities/favorite_movie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMovieDetailView extends StatelessWidget {
  final FavoriteMovie movie;
  final String heroTag;

  const ProfileMovieDetailView({
    super.key,
    required this.movie,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientColor = theme.scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: heroTag,
            child: CachedNetworkImage(
              imageUrl: movie.posterUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  gradientColor.withOpacity(0.9),
                  gradientColor.withOpacity(0.7),
                  Colors.transparent,
                ],
                stops: const [0, 0.5, 1.0],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
              child: _buildExpandedInfo(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedInfo(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeAnimation(
          delay: 0.5,
          child: Text(
            movie.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        FadeAnimation(
          delay: 0.6,
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              SizedBox(width: 4.w),
              Text(
                '${movie.imdbRating} IMDB',
                style: TextStyle(color: textColor),
              ),
              SizedBox(width: 16.w),
              Text(
                movie.genre,
                style: TextStyle(color: textColor.withOpacity(0.7)),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        FadeAnimation(
          delay: 0.7,
          child: Text(
            movie.plot,
            style: TextStyle(
              fontSize: 14.sp,
              color: textColor.withOpacity(0.9),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        FadeAnimation(
          delay: 0.8,
          child: Text(
            '${context.l10n.translate('actors')}: ${movie.actors}',
            style: TextStyle(color: textColor.withOpacity(0.7)),
          ),
        ),
        SizedBox(height: 16.h),
        if (movie.images.isNotEmpty)
          FadeAnimation(
            delay: 0.9,
            child: SizedBox(
              height: 100.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movie.images.length,
                itemBuilder: (context, index) {
                  final imageUrl = movie.images[index];
                  final heroTag = '${movie.id}_${movie.images[index]}';
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => FullScreenImageView(
                              images: movie.images,
                              initialIndex: index,
                              movieId: movie.id,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: heroTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            width: 150.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
