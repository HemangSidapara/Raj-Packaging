part of 'image_picker_bloc.dart';

sealed class ImagePickerState extends Equatable {
  const ImagePickerState();
}

final class ImagePickerInitial extends ImagePickerState {
  @override
  List<Object> get props => [];
}
