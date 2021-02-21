import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:havass_coaching_flutter/plugins/localization_services/app_localizations.dart';
import 'package:havass_coaching_flutter/plugins/shared_Preferences/pref_utils.dart';

enum LocaleEvent { EN, DE }

class BlocLocalization extends Bloc<LocaleEvent, Locale> {
  BlocLocalization({Locale initialState}) : super(initialState);

  @override
  // ignore: override_on_non_overriding_member
  Locale get initialState => Locale("en");

  @override
  Stream<Locale> mapEventToState(LocaleEvent event) async* {
    Locale locale = event == LocaleEvent.DE ? Locale("de") : Locale("en");
    await AppLocalizations.updateLocale(locale);
    PrefUtils.saveLanguage(locale);
    yield locale;
  }
}
