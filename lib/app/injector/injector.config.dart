// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_shop/src/application/weather/weather_bloc.dart' as _i6;
import 'package:coffee_shop/src/domain/weather/i_weather_repostitory.dart'
    as _i4;
import 'package:coffee_shop/src/infrastructure/core/third_party_injectable_module.dart'
    as _i7;
import 'package:coffee_shop/src/infrastructure/weather/weather_repostitory.dart'
    as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyInjectableModule = _$ThirdPartyInjectableModule();
    gh.lazySingleton<_i3.Client>(() => thirdPartyInjectableModule.client);
    gh.lazySingleton<_i4.IWeatherRepository>(
        () => _i5.WeatherRepository(gh<_i3.Client>()));
    gh.factory<_i6.WeatherBloc>(
        () => _i6.WeatherBloc(gh<_i4.IWeatherRepository>()));
    return this;
  }
}

class _$ThirdPartyInjectableModule extends _i7.ThirdPartyInjectableModule {}
