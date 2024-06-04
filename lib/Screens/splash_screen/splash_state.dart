part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();
}

final class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

final class SplashAuthorized extends SplashState {
  @override
  List<Object> get props => [];
}
