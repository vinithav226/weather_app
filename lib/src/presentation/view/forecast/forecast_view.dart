import 'package:coffee_shop/src/application/core/status.dart';
import 'package:coffee_shop/src/application/weather/weather_bloc.dart';
import 'package:coffee_shop/src/presentation/core/theme/colors.dart';
import 'package:coffee_shop/src/presentation/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ForeCastView extends StatefulWidget {
  const ForeCastView({super.key});

  @override
  State<ForeCastView> createState() => _ForeCastViewState();
}

class _ForeCastViewState extends State<ForeCastView> {
  @override
  void initState() {
    context.read<WeatherBloc>().add(GetForeCastWeatherDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<WeatherBloc>().add(GetForeCastWeatherDataEvent());
          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.purple,
                ],
                stops: [0.3, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state.forcastStatus is StatusLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 8,
                        color: AppColors.textWhiteColor,
                      ),
                    );
                  } else if (state.forcastStatus is StatusSuccess) {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final temp =
                            state.forecastData?.forecast?[index].main?.temp ??
                                0;
                        final cel = temp - 275;
                        final finalCel = cel.toInt();
                        final date = DateFormat('EEE').add_jm().format(
                              DateTime.parse(
                                state.forecastData?.forecast![index].dtTxt ??
                                    '',
                              ),
                            );
                        final newDate = date.split(' ');
                        final icon = state.forecastData?.forecast?[index]
                                .weather?.first.icon ??
                            '';
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newDate[0],
                                  style: AppTypography.s16W400TextStyle,
                                ),
                                Text(
                                  newDate[1],
                                  style: AppTypography.s16W400TextStyle,
                                ),
                              ],
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    'https://openweathermap.org/img/wn/$icon@2x.png',
                                  ),
                                  Text(
                                    state.forecastData?.forecast?[index].weather
                                            ?.first.main ??
                                        '',
                                    style: AppTypography.s16W400TextStyle,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$finalCel\u2103',
                              style: const TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 12,
                          child: Divider(
                            color: Colors.deepPurpleAccent,
                          ),
                        );
                      },
                      itemCount: state.forecastData?.cnt ?? 0,
                    );
                  } else if (state.forcastStatus is StatusFailure) {
                    return Center(
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<WeatherBloc>()
                              .add(GetForeCastWeatherDataEvent());
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
      ),
    );
  }
}
