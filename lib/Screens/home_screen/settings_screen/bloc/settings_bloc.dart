import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/services/utils_services/get_package_info_service.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsStartedEvent>((event, emit) async {
      add(SettingsGetCurrentVersionEvent(currentVersion: (await GetPackageInfoService.instance.getInfo()).version));

      final currentLocale = getLocal();
      add(SettingsGetCurrentLocalEvent(
        isGujaratiLang: currentLocale.languageCode == "gu",
        isHindiLang: currentLocale.languageCode == "hi",
      ));
    });

    on<SettingsGetCurrentLocalEvent>((event, emit) {
      emit(SettingsGetCurrentLocalState(isGujaratiLang: event.isGujaratiLang, isHindiLang: event.isHindiLang));
    });

    on<SettingsSetNewLocalEvent>((event, emit) async {
      await S.load(event.locale);
      setData(AppConstance.languageCode, event.locale.languageCode);
      setData(AppConstance.languageCountryCode, event.locale.countryCode);
      final currentLocale = getLocal();
      add(SettingsGetCurrentLocalEvent(
        isGujaratiLang: currentLocale.languageCode == "gu",
        isHindiLang: currentLocale.languageCode == "hi",
      ));
    });

    on<SettingsGetCurrentVersionEvent>((event, emit) {
      emit(SettingsCurrentVersionState(currentVersion: event.currentVersion));
    });

    on<SettingsLogOutClickedEvent>((event, emit) async {
      await checkLogOut(emit);
    });

    on<SettingsLogOutLoadingEvent>((event, emit) async {
      emit(SettingsLogOutLoadingState(isLoading: event.isLoading));
    });
  }

  Locale getLocal() {
    final languageCode = getString(AppConstance.languageCode) ?? "en";
    final countryCode = getString(AppConstance.languageCountryCode) ?? "US";
    return Locale(languageCode, countryCode);
  }

  ///Log Out Api
  Future<void> checkLogOut(Emitter<SettingsState> emit) async {
    try {
      add(const SettingsLogOutLoadingEvent(isLoading: true));
      await Future.delayed(const Duration(seconds: 3));
      await clearData();
      emit(SettingsLogOutSuccessState());
    } finally {
      add(const SettingsLogOutLoadingEvent(isLoading: false));
    }
  }
}
