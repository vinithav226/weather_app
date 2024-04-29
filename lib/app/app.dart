import 'package:coffee_shop/app/injector/injector.dart';
import 'package:coffee_shop/src/application/weather/weather_bloc.dart';
import 'package:coffee_shop/src/presentation/core/theme/theme.dart';
import 'package:coffee_shop/src/presentation/view/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
