import 'package:flutter/material.dart';
import 'package:map_pro/bloc/country/country_bloc.dart';
import 'package:map_pro/bloc/country/country_event.dart';
import 'package:map_pro/model/country_model.dart';

class CountryController {
  final CountryBloc countryBloc;
  CountryController({required this.countryBloc});

  final ValueNotifier<List<Country>> countriesList = ValueNotifier<List<Country>>([]);
  final ValueNotifier<Country?> selectedCountry = ValueNotifier<Country?>(null);

  void fetchCountryList()
  {
    countryBloc.add(FetchCountries());
  }

  void setSelectedCountry(Country? country)
  {
    selectedCountry.value = country;
  }


}
