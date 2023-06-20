import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/widgets/blur_container/blur_container.dart';

class SevenDaysWidget extends StatelessWidget {
  const SevenDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return BlurContainer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
        shrinkWrap: true,
        itemBuilder: (context, i) => SevenDaysItem(
          day: model.date[i],
          dayTemp: model.setDayTemp(i),
          nightTemp: model.setNightTemp(i),
          icon: model.setDailyIcon(i),
        ),
        separatorBuilder: (context, i) => const SizedBox(height: 8),
        itemCount: model.date.length,
      ),
    );
  }
}

class SevenDaysItem extends StatelessWidget {
  final String day;
  final int dayTemp;
  final int nightTemp;
  final String icon;
  const SevenDaysItem({
    super.key,
    required this.day,
    required this.dayTemp,
    required this.nightTemp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            day,
            style: TextStyle(
              fontSize: 20,
              height: 22 / 20,
              color: AppColors.textColor,
            ),
          ),
        ),
        Image.network(
          icon,
          width: 40,
          height: 40,
          color: AppColors.textColor,
        ),
        DayNigthTemp(
          dayTemp: dayTemp,
          nigthTemp: nightTemp,
        ),
      ],
    );
  }
}

class DayNigthTemp extends StatelessWidget {
  final int dayTemp;
  final int nigthTemp;
  const DayNigthTemp({
    super.key,
    this.dayTemp = 5,
    this.nigthTemp = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$dayTemp℃',
            style: TextStyle(
              fontSize: 20,
              height: 22 / 20,
              color: AppColors.textColor,
            ),
          ),
          Text(
            '$nigthTemp℃',
            style: TextStyle(
              fontSize: 20,
              height: 22 / 20,
              color: AppColors.valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
