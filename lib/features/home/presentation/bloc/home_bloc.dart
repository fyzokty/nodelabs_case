import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/pagination.dart';
import '../../domain/usecase/favorite_movie.dart';
import '../../domain/usecase/fecth_movie_list.dart';
import '../../domain/usecase/fetch_favorite_list.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FecthMovieList fecthMovieList;
  final FetchFavoriteList fetchFavoriteList;
  final FavoriteMovie favoriteMovie;

  int activePageViewIndex = 0;
  late Pagination pagination;
  List<Movie> movieList = [];
  List<Movie> favoriteList = [];

  HomeBloc({required this.fecthMovieList, required this.fetchFavoriteList, required this.favoriteMovie})
    : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeFirstLoad>(_onFirstLoad);
    on<ExploreLoadMore>(_onLoadMore);
    on<HomeFavoriteMovie>(_onFavorite);
    on<ExplorePageChanged>(_onPageChanged);
  }

  void _onFirstLoad(HomeFirstLoad event, Emitter<HomeState> emit) async {
    emit(HomeFirstLoading());
    final resM = await fecthMovieList(FetchMovieListParams(1));
    final resF = await fetchFavoriteList(NoParams());

    resM.fold(
      (fail) {
        log("_onFirstLoad fail:  ${fail.text}");
        emit(HomeFirstFailure(fail.text));
      },
      (mL) {
        log("_onFirstLoad mL:  $mL");
        movieList.clear();
        movieList.addAll(mL.movies);
        pagination = mL.pagination;
        emit(HomeFirstPageSuccess());
      },
    );

    resF.fold((fail) => emit(HomeFirstFailure(fail.text)), (fL) {
      favoriteList.clear();
      favoriteList.addAll(fL);
      emit(HomeFirstPageSuccess());
    });
  }

  void _onLoadMore(ExploreLoadMore event, Emitter<HomeState> emit) async {
    if (pagination.isLastPage) return;
    emit(HomePageLoading());
    final res = await fecthMovieList(FetchMovieListParams(pagination.currentPage + 1));

    res.fold((fail) => emit(HomePageLoadingFailure(fail.text)), (mL) {
      pagination = mL.pagination;
      movieList.addAll(mL.movies);
      emit(HomePageLoadingSuccess());
    });
  }

  void _onFavorite(HomeFavoriteMovie event, Emitter<HomeState> emit) async {
    final resF = await favoriteMovie(FavoriteMovieParams(event.movieID));

    final resFL = await fetchFavoriteList(NoParams());

    resF.fold((fail) => emit(HomeFavoriteFailure(fail.text)), (movie) => emit(HomeFavoriteSuccess()));
    resFL.fold((fail) => emit(HomeFirstFailure(fail.text)), (fL) {
      favoriteList.clear();
      favoriteList.addAll(fL);
      emit(HomeFirstPageSuccess());
    });
  }

  void _onPageChanged(ExplorePageChanged event, Emitter<HomeState> emit) {
    activePageViewIndex = event.activeIndex;
    emit(HomeFirstPageSuccess());
  }
}
