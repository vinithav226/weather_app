import 'package:coffee_shop/src/application/core/status.dart';
import 'package:coffee_shop/src/application/weather/weather_bloc.dart';
import 'package:coffee_shop/src/presentation/core/theme/colors.dart';
import 'package:coffee_shop/src/presentation/core/theme/typography.dart';
import 'package:coffee_shop/src/presentation/view/forecast/forecast_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(GetUserLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              final hour = DateTime.now().hour;
              var salutation = 'Welcome';
              if (hour < 12) {
                salutation = 'Good Morning!';
              }
              if (hour <= 17) {
                salutation = 'Good Afternoon!';
              }
              if (hour > 17) {
                salutation = 'Good Evening!';
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.cityName ?? '',
                    style: AppTypography.subtitleTextStyle,
                  ),
                  Text(
                    salutation,
                    style: AppTypography.titleTextStyle,
                  ),
                ],
              );
            },
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<WeatherBloc>().add(GetUserLocationEvent());
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
                stops: [0.3, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                final kelvin = state.weatherData?.main?.temp ?? 0;
                final celsius = kelvin - 272.15;
                final finalCel = celsius.ceil();
                final icon = state.weatherData?.weather?.first.icon;
                if (state.locationAccessStatus is StatusLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      color: AppColors.textWhiteColor,
                    ),
                  );
                } else if (state.locationAccessStatus is StatusSuccess) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://openweathermap.org/img/wn/$icon@4x.png',
                        ),
                        Text(
                          '$finalCel\u2103',
                          style: const TextStyle(
                            fontSize: 52,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          state.weatherData?.weather?.first.main ?? '',
                          style: AppTypography.bodyTextStyle,
                        ),
                        Text(
                          state.weatherData?.weather?.first.description ?? '',
                          style: AppTypography.bodyTextStyle,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          DateFormat.yMMMMd().add_jm().format(DateTime.now()),
                          style: AppTypography.bodyTextStyle,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const ForeCastView(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Next Days',
                                style: AppTypography.subtitleTextStyle
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(
                                Icons.arrow_circle_right,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.locationAccessStatus is StatusFailure) {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<WeatherBloc>().add(GetUserLocationEvent());
                      },
                      child: Text(
                        'Retry',
                        style: AppTypography.subtitleTextStyle
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
