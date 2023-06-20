import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/data/resourses/app_icons.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.cloudy,
              color: AppColors.textColor,
            ),
            const SizedBox(width: 24),
            Text(
              model.setCurrentStatus(),
              style: TextStyle(
                fontSize: 16,
                height: 22 / 16,
                color: AppColors.textColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Text(
          '${model.setCurrentTemp()}℃',
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 90,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MinMaxTemp.max(deg: model.setCurrentMaxTemp()),
            const SizedBox(width: 65),
            MinMaxTemp.min(deg: model.setCurrentMinTemp())
          ],
        )
      ],
    );
  }
}

class MinMaxTemp extends StatelessWidget {
  final String icon;
  final int deg;

  const MinMaxTemp.min({super.key, this.deg = 0}) : icon = AppIcons.min;

  const MinMaxTemp.max({super.key, this.deg = 0}) : icon = AppIcons.max;

  @override
  Widget build(BuildContext context) {
    String currentTemp = deg < 10 && deg > 0 ? '0$deg°' : '$deg°';
    if (deg > -10 && deg < 0) currentTemp = '-0${-deg}°';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon),
        const SizedBox(width: 4),
        Text(
          currentTemp,
          style: TextStyle(
            fontSize: 25,
            height: 23 / 25,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
