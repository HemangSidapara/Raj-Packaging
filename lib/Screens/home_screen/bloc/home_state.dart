part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeChangeBottomIndexState extends HomeState {
  final int bottomIndex;

  const HomeChangeBottomIndexState({required this.bottomIndex});

  @override
  List<Object?> get props => [bottomIndex];
}

final class HomeOnUpdateAvailableState extends HomeState {
  final bool isLatestVersionAvailable;
  final String newAPKVersion;
  final String newAPKUrl;

  const HomeOnUpdateAvailableState({
    required this.isLatestVersionAvailable,
    required this.newAPKVersion,
    required this.newAPKUrl,
  });

  @override
  List<Object?> get props => [isLatestVersionAvailable];
}

class HomeUpdateProgressState extends HomeState {
  final bool isUpdateLoading;
  final int downloadedProgress;

  const HomeUpdateProgressState({required this.isUpdateLoading, required this.downloadedProgress});

  @override
  List<Object?> get props => [isUpdateLoading, downloadedProgress];
}

class HomeCheckTokenSuccessState extends HomeState {
  final int statusCode;
  final String message;

  const HomeCheckTokenSuccessState({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}

class HomeCheckTokenFailedState extends HomeState {
  final int statusCode;
  final String message;

  const HomeCheckTokenFailedState({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}
