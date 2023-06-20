import 'package:flutter/material.dart';
import 'package:weather_app/ui/router/app_routes.dart';

abstract class ErrorPage {
  static Route get errorPage {
    return MaterialPageRoute(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.home,
              (route) => false,
            );
          },
          child: Scaffold(
            backgroundColor: const Color(0xff323232),
            body: Center(
              child: Image.asset('assets/gif/giphy.gif'),
            ),
          ),
        );
      },
    );
  }
}
