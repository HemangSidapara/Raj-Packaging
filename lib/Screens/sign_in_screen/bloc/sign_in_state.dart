part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();
}

final class SignInInitialState extends SignInState {
  @override
  List<Object> get props => [];
}

final class SignInPasswordVisibilityState extends SignInState {
  final bool isPasswordVisible;

  const SignInPasswordVisibilityState({
    required this.isPasswordVisible,
  });

  @override
  List<Object?> get props => [isPasswordVisible];
}

final class SignInLoadingState extends SignInState {
  final bool isLoading;

  const SignInLoadingState({required this.isLoading});

  @override
  List<Object> get props => [isLoading];
}

final class SignInSuccessState extends SignInState {
  final LoginModel loginModel;

  const SignInSuccessState({required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}

final class SignInFailedState extends SignInState {
  @override
  List<Object> get props => [];
}
