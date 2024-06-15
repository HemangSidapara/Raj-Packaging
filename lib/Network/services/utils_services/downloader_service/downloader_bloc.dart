import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:raj_packaging/Constants/app_utils.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'downloader_event.dart';
part 'downloader_state.dart';

class DownloaderBloc extends Bloc<DownloaderEvent, DownloaderState> {
  DownloaderBloc({required BuildContext context}) : super(DownloaderInitial()) {
    on<DownloadFile>((event, emit) {
      mapEventToState(context, event);
    });
  }

  Stream<DownloaderState> mapEventToState(BuildContext context, DownloaderEvent event) async* {
    if (event is DownloadFile) {
      yield* _mapDownloadFileToState(context, event);
    }
  }

  Stream<DownloaderState> _mapDownloadFileToState(BuildContext context, DownloadFile event) async* {
    try {
      final dio = Dio();
      yield const DownloadInProgress(0.0);

      final response = await dio.download(
        event.url,
        "/storage/emulated/0/Download/${event.fileName}",
        onReceiveProgress: (count, total) {
          add(UpdateProgress(count * 100 / total));
        },
      );

      if (response.statusCode! >= 200 && response.statusCode! <= 299) {
        Utils.handleMessage(message: S.current.successfullyDownloadedAtDownloadFolder);
        yield DownloadSuccess(File("/storage/emulated/0/Download/${event.fileName}"));
      } else {
        Utils.handleMessage(message: S.current.downloadFailedPleaseTryAgain, isError: true);
        yield DownloadFailure();
      }
    } catch (error) {
      Utils.handleMessage(message: S.current.downloadFailedPleaseTryAgain, isError: true);
      yield DownloadFailure();
    }
  }
}
