part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

final class HomeStartedEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

final class HomeChangeBottomIndexEvent extends HomeEvent {
  final int bottomIndex;

  const HomeChangeBottomIndexEvent({required this.bottomIndex});

  @override
  List<Object?> get props => [bottomIndex];
}

class HomeUpdateAvailableEvent extends HomeEvent {
  final bool isLatestVersionAvailable;
  final String newAPKVersion;
  final String newAPKUrl;

  const HomeUpdateAvailableEvent({
    required this.isLatestVersionAvailable,
    required this.newAPKVersion,
    required this.newAPKUrl,
  });

  @override
  List<Object?> get props => [isLatestVersionAvailable];
}

class HomeDownloadAndInstallStartEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class HomeDownloadAndInstallInProgressEvent extends HomeEvent {
  final bool isUpdateLoading;
  final int downloadedProgress;

  const HomeDownloadAndInstallInProgressEvent({required this.isUpdateLoading, required this.downloadedProgress});

  @override
  List<Object?> get props => [isUpdateLoading, downloadedProgress];
}
