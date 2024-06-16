part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();
}

final class SettingsInitial extends SettingsState {
  @override
  List<Object> get props => [];
}

final class SettingsGetCurrentLocalState extends SettingsState {
  final bool isGujaratiLang;
  final bool isHindiLang;

  const SettingsGetCurrentLocalState({required this.isGujaratiLang, required this.isHindiLang});

  @override
  List<Object> get props => [isGujaratiLang, isHindiLang];
}

class SettingsCurrentVersionState extends SettingsState {
  final String currentVersion;

  const SettingsCurrentVersionState({required this.currentVersion});

  @override
  List<Object?> get props => [currentVersion];
}

class SettingsLogOutLoadingState extends SettingsState {
  final bool isLoading;

  const SettingsLogOutLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class SettingsLogOutSuccessState extends SettingsState {
  @override
  List<Object?> get props => [];
}

class SettingsLogOutFailedState extends SettingsState {
  @override
  List<Object?> get props => [];
}
