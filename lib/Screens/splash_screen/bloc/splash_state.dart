part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitialState extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashCurrentVersionState extends SplashState {
  final String currentVersion;
  const SplashCurrentVersionState({required this.currentVersion});

  @override
  List<Object?> get props => [currentVersion];
}

final class SplashAuthorizedState extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashUnauthorizedState extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashOnUpdateAvailableState extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashUpdateProgressState extends SplashState {
  final bool isUpdateLoading;
  final int downloadedProgress;

  const SplashUpdateProgressState({required this.isUpdateLoading, required this.downloadedProgress});

  @override
  List<Object?> get props => [isUpdateLoading, downloadedProgress];
}
