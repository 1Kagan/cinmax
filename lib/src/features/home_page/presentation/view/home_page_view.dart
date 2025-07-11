import 'dart:ui';

import 'package:core_dls/core_dls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/l10n/l10n.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_bloc.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_event.dart';
import 'package:flutter_base/src/features/home_page/presentation/state/home_page_state.dart';
import 'package:flutter_base/src/features/home_page/presentation/widgets/movie_card.dart';
import 'package:flutter_base/src/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<HomePageBloc>()..add(MoviesFetched()),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatelessWidget {
  const _HomePageContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        switch (state.status) {
          case HomePageStatus.initial:
          case HomePageStatus.loading:
            return Center(
                child: SpinKitDoubleBounce(
                    color: isLight ? Colors.black : Colors.white));
          case HomePageStatus.failure:
            return Center(
              child: Text(
                state.errorMessage ??
                    context.l10n.translate('failed_to_fetch_movies'),
              ),
            );
          case HomePageStatus.success:
            if (state.movies.isEmpty) {
              return Center(
                child: Text(
                  context.l10n.translate('no_movies_found'),
                ),
              );
            }
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomePageBloc>().add(MoviesRefreshed());
                  },
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: state.hasReachedMax
                        ? state.movies.length
                        : state.movies.length + 1,
                    onPageChanged: (index) {
                      context
                          .read<HomePageBloc>()
                          .add(HomePageIndexChanged(index));
                      if (index >= state.movies.length - 2) {
                        context.read<HomePageBloc>().add(MoviesFetched());
                      }
                    },
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= state.movies.length) {
                        return Center(
                          child: SpinKitDoubleBounce(
                              color: isLight ? Colors.black : Colors.white),
                        );
                      }
                      return MovieCard(movie: state.movies[index]);
                    },
                  ),
                ),
                if (state.movies.isNotEmpty && !state.isCardExpanded)
                  Positioned(
                    bottom: 100.h,
                    right: 14.w,
                    child: GestureDetector(
                      onTap: () {
                        if (state.currentMovieIndex < state.movies.length) {
                          final movie = state.movies[state.currentMovieIndex];
                          context
                              .read<HomePageBloc>()
                              .add(FavoriteTogglePressed(movie.id));
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            height: 70.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: theme.colorScheme.surface.withOpacity(0.2),
                              border: Border.all(
                                width: 1,
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.2),
                              ),
                            ),
                            child: Icon(
                              state.movies[state.currentMovieIndex].isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
        }
      },
    );
  }
}
