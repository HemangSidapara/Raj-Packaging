part of 'downloader_bloc.dart';

abstract class DownloaderState extends Equatable {
  const DownloaderState();

  @override
  List<Object> get props => [];
}

class DownloaderInitial extends DownloaderState {}

class DownloadInProgress extends DownloaderState {
  final double progress;

  const DownloadInProgress(this.progress);

  @override
  List<Object> get props => [progress];
}

class DownloadSuccess extends DownloaderState {
  final File file;

  const DownloadSuccess(this.file);

  @override
  List<Object> get props => [file];
}

class DownloadFailure extends DownloaderState {}
