part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class SettingsStartedEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}

final class SettingsGetCurrentLocalEvent extends SettingsEvent {
  final bool isGujaratiLang;
  final bool isHindiLang;

  const SettingsGetCurrentLocalEvent({required this.isGujaratiLang, required this.isHindiLang});

  @override
  List<Object?> get props => [isGujaratiLang, isHindiLang];
}

final class SettingsSetNewLocalEvent extends SettingsEvent {
  final Locale locale;

  const SettingsSetNewLocalEvent({required this.locale});

  @override
  List<Object?> get props => [locale];
}

final class SettingsGetCurrentVersionEvent extends SettingsEvent {
  final String currentVersion;

  const SettingsGetCurrentVersionEvent({required this.currentVersion});

  @override
  List<Object?> get props => [currentVersion];
}

class SettingsLogOutLoadingEvent extends SettingsEvent {
  final bool isLoading;

  const SettingsLogOutLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class SettingsLogOutClickedEvent extends SettingsEvent {
  @override
  List<Object?> get props => [];
}
