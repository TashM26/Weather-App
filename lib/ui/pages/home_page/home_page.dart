import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/providers/weather_provider.dart';
import 'package:weather_app/data/resourses/bg.dart';
import 'package:weather_app/ui/widgets/home_page_app_bar/home_page_app_bar.dart';
import 'package:weather_app/ui/widgets/home_page_body/body_block_widget.dart';
import 'package:weather_app/ui/widgets/home_page_body/seven_days_widget.dart';
import 'package:weather_app/ui/widgets/home_page_footer/home_page_footer.dart';
import 'package:weather_app/ui/widgets/home_page_header/home_page_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildBody(
      BuildContext context,
      AsyncSnapshot snapshot,
    ) {
      switch (snapshot.connectionState) {
        case ConnectionState.done:
          return const HomePageContent();
        case ConnectionState.waiting:
        default:
          return const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
      }
    }

    final model = Provider.of<WeatherProvider>(context);
    return Scaffold(
      body: FutureBuilder(
        future: context
            .watch<WeatherProvider>()
            .setUp(cityName: model.cityController.text),
        builder: _buildBody,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Ink(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(model.setWeatherTheme()),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const HomePageAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(
                  top: 44,
                  bottom: 31,
                  left: 16,
                  right: 16,
                ),
                children: const [
                  HomePageHeader(),
                  SizedBox(height: 40),
                  SevenDaysWidget(),
                  SizedBox(height: 28),
                  BodyBlockWidget(),
                  SizedBox(height: 30),
                  HomePageFooter(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
