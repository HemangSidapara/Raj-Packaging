part of 'downloader_bloc.dart';

abstract class DownloaderEvent extends Equatable {
  const DownloaderEvent();

  @override
  List<Object> get props => [];
}

class DownloadFile extends DownloaderEvent {
  final String url;
  final String fileName;

  const DownloadFile({required this.url, required this.fileName});

  @override
  List<Object> get props => [url, fileName];
}

class UpdateProgress extends DownloaderEvent {
  final double progress;

  const UpdateProgress(this.progress);

  @override
  List<Object> get props => [progress];
}
