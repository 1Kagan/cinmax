import 'package:cached_network_image/cached_network_image.dart';
import 'package:core_dls/core_dls.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/home_page/domain/entities/movie.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_bloc.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_event.dart';
import 'package:flutter_base/src/features/home_page/presentation/view/full_screen_image_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      context.read<HomePageBloc>().add(CardExpansionChanged(_isExpanded));
    });
  }

  @override
  Widget build(BuildContext context) {
    final shortPlot = widget.movie.plot.length > 100
        ? '${widget.movie.plot.substring(0, 100)}'
        : widget.movie.plot;
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final gradientColor = isLight ? theme.cardColor : Colors.black;

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: widget.movie.poster,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SpinKitDoubleBounce(
                color: isLight ? Colors.black : Colors.white),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: _isExpanded ? Alignment.topCenter : Alignment.center,
                colors: [
                  gradientColor.withOpacity(0.9),
                  gradientColor.withOpacity(_isExpanded ? 0.9 : 0.7),
                  Colors.transparent,
                ],
                stops: _isExpanded ? const [0, 0.6, 1.0] : const [0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: AnimatedCrossFade(
            duration: const Duration(milliseconds: 400),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: _buildCollapsedInfo(shortPlot),
            secondChild: _buildExpandedInfo(),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsedInfo(String shortPlot) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.movie.title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 8.h),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              color: textColor.withOpacity(0.8),
            ),
            children: [
              TextSpan(text: '$shortPlot... '),
              TextSpan(
                text: context.l10n.translate('read_more'),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                recognizer: TapGestureRecognizer()..onTap = _toggleExpanded,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedInfo() {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.movie.title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            SizedBox(width: 4.w),
            Text(
              '${widget.movie.imdbRating} IMDB',
              style: TextStyle(color: textColor),
            ),
            SizedBox(width: 16.w),
            Text(
              widget.movie.genre,
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          widget.movie.plot,
          style: TextStyle(
            fontSize: 14.sp,
            color: textColor.withOpacity(0.9),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '${context.l10n.translate('actors')}: ${widget.movie.actors}',
          style: TextStyle(color: textColor.withOpacity(0.7)),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.movie.images.length,
            itemBuilder: (context, index) {
              final imageUrl = widget.movie.images[index];
              final heroTag = '${widget.movie.id}_$imageUrl';
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FullScreenImageView(
                          images: widget.movie.images,
                          initialIndex: index,
                          movieId: widget.movie.id,
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
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _toggleExpanded,
          child: Text(
            context.l10n.translate('read_less'),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
