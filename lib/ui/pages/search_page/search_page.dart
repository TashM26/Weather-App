import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/data/resourses/app_icons.dart';
import 'package:weather_app/data/resourses/bg.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD8E8F0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchPageAppBAr(),
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 28),
                CurrentRegionCard(),
                SizedBox(height: 24),
                Text(
                  'Избранное',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff323232),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const FavoriteList(),
          ],
        ),
      ),
    );
  }
}

class SearchPageAppBAr extends StatelessWidget {
  const SearchPageAppBAr({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          Expanded(
            child: TextField(
              controller: model.cityController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(4),
                ),
                fillColor: const Color.fromRGBO(109, 160, 192, .13),
                filled: true,
                hintText: 'Введите город/регион',
                hintStyle: const TextStyle(
                  fontSize: 16,
                  height: 22 / 14,
                  color: Color.fromRGBO(0, 0, 0, .5),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              model.setCity(context);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

class CurrentRegionCard extends StatelessWidget {
  const CurrentRegionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Bg.clearBg),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          CurrentCardInfo(),
          CurrentCardTempInfo(),
        ],
      ),
    );
  }
}

class CurrentCardInfo extends StatelessWidget {
  const CurrentCardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Текущее место',
          style: TextStyle(
            fontSize: 12,
            height: 22 / 12,
            color: AppColors.textColor,
          ),
        ),
        Text(
          'Ташкент',
          style: TextStyle(
            fontSize: 18,
            height: 22 / 18,
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Азия/Ташкент',
          style: TextStyle(
            fontSize: 12,
            height: 22 / 12,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}

class CurrentCardTempInfo extends StatelessWidget {
  final bool isOnline;
  const CurrentCardTempInfo({super.key, this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.cloudy,
          color: AppColors.textColor,
        ),
        const SizedBox(width: 10),
        Text(
          '10℃',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}

class FavoriteList extends StatelessWidget {
  const FavoriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        controller: ScrollController(),
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Bg.clearBg),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CurrentCardInfo(),
              CurrentCardTempInfo(),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: 10,
      ),
    );
  }
}
