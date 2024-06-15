part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashCurrentVersion extends SplashState {
  @override
  List<Object?> get props => [];
}

final class SplashAuthorized extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashUnauthorized extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashOnUpdateAvailable extends SplashState {
  @override
  List<Object?> get props => [];
}

class SplashUpdateProgress extends SplashState {
  final bool isUpdateLoading;
  final int downloadedProgress;

  const SplashUpdateProgress({required this.isUpdateLoading, required this.downloadedProgress});

  @override
  List<Object?> get props => [isUpdateLoading, downloadedProgress];
}
