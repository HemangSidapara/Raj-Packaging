part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {}

class SplashStartedEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashGetCurrentVersionEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashAuthorizedEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashUnauthorizedEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashUpdateAvailableEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashDownloadAndInstallStartEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

class SplashDownloadAndInstallInProgressEvent extends SplashEvent {
  final bool isUpdateLoading;
  final int downloadedProgress;

  SplashDownloadAndInstallInProgressEvent({required this.isUpdateLoading, required this.downloadedProgress});

  @override
  List<Object?> get props => [isUpdateLoading, downloadedProgress];
}
