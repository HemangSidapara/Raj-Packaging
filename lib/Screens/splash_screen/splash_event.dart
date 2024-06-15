part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {}

class SplashStarted extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashGetCurrentVersion extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashUpdateAvailable extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashDownloadAndInstall extends SplashEvent {
  @override
  List<Object?> get props => [];
}
