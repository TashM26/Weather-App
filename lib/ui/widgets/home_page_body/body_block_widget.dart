import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/data/resourses/app_icons.dart';
import 'package:weather_app/ui/theme/app_colors.dart';
import 'package:weather_app/ui/widgets/blur_container/blur_container.dart';

class BodyBlockWidget extends StatelessWidget {
  const BodyBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 181,
          mainAxisExtent: 160,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, i) => BlockCardItem(
          subTitle: BlockCardWidgetOptions.subTitle[i],
          icon: BlockCardWidgetOptions.icons[i],
          value: model.setValues(i),
          units: BlockCardWidgetUnits.values[i],
        ),
      ),
    );
  }
}

class BlockCardItem extends StatelessWidget {
  final String icon;
  final String subTitle;
  final double? value;
  final BlockCardWidgetUnits units;
  const BlockCardItem({
    super.key,
    this.icon = AppIcons.windSpeed,
    this.subTitle = 'Скорость ветра',
    this.value = 0,
    required this.units,
  });

  @override
  Widget build(BuildContext context) {
    String unit = BlockCardWidgetTreatment.unitsTreatment(units);
    return BlurContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: AppColors.textColor,
          ),
          const SizedBox(width: 6),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${value ?? 'Error'} $unit',
                style: TextStyle(
                  fontSize: 18,
                  height: 22 / 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.valueColor,
                ),
              ),
              Text(
                subTitle,
                style: TextStyle(
                  fontSize: 12,
                  height: 22 / 10,
                  color: AppColors.textColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BlockCardWidgetOptions {
  static List<String> icons = [
    AppIcons.windSpeed,
    AppIcons.feelsLike,
    AppIcons.hummidity,
    AppIcons.visibility,
  ];

  static List<String> subTitle = [
    'Скорость ветра',
    'Ощущается',
    'Влажность',
    'Видимость',
  ];
}

enum BlockCardWidgetUnits { kmh, deg, percent, km }

class BlockCardWidgetTreatment {
  static String unitsTreatment(BlockCardWidgetUnits units) {
    switch (units) {
      case BlockCardWidgetUnits.km:
        return 'км';
      case BlockCardWidgetUnits.deg:
        return '°';
      case BlockCardWidgetUnits.kmh:
        return 'км/ч';
      default:
        return '%';
    }
  }
}
