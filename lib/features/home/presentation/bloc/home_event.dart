part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeFirstLoad extends HomeEvent {}

final class ExploreLoadMore extends HomeEvent {}

final class HomeFavoriteMovie extends HomeEvent {
  HomeFavoriteMovie(this.movieID);
  final String movieID;
}

final class ProfileReload extends HomeEvent {}

final class ExplorePageChanged extends HomeEvent {
  ExplorePageChanged(this.activeIndex);
  final int activeIndex;
}
