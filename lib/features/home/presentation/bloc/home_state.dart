part of 'home_bloc.dart';

@immutable
sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class HomeFirstLoading extends HomeState {}

final class HomeFirstFailure extends HomeState {
  const HomeFirstFailure(this.message);
  final String message;
}

final class HomeFirstPageSuccess extends HomeState {}

final class HomePageLoading extends HomeState {}

final class HomePageLoadingSuccess extends HomeState {}

final class HomePageLoadingFailure extends HomeState {
  const HomePageLoadingFailure(this.message);
  final String message;
}

final class HomeFavoriteLoading extends HomeState {}

final class HomeFavoriteFailure extends HomeState {
  const HomeFavoriteFailure(this.message);
  final String message;
}

final class HomeFavoriteSuccess extends HomeState {}
