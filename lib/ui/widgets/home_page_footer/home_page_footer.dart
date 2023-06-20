import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/data/resourses/app_icons.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/widgets/blur_container/blur_container.dart';

class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return BlurContainer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 47, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <SunsetSunriseCard>[
            SunsetSunriseCard(
              text: 'Восход ${model.setSunriseTime()}',
            ),
            SunsetSunriseCard(
              icon: AppIcons.sunset,
              text: 'Закат ${model.setSunsetTime()}',
            ),
          ],
        ),
      ),
    );
  }
}

class SunsetSunriseCard extends StatelessWidget {
  final String icon;
  final String text;
  const SunsetSunriseCard({
    super.key,
    this.icon = AppIcons.sunrise,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          color: AppColors.textColor,
        ),
        const SizedBox(height: 18),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            height: 22 / 16,
            // color: AppColors.valueColor,
          ).copyWith(
            color: AppColors.valueColor,
          ),
        ),
      ],
    );
  }
}
