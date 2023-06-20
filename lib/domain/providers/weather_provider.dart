import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/weather_api/weather_api.dart';
import 'package:weather_app/domain/weather_json/coords.dart';
import 'package:weather_app/domain/weather_json/weather_data.dart';
import 'package:weather_app/data/resourses/bg.dart';
import 'package:weather_app/ui/theme/app_colors.dart';

class WeatherProvider extends ChangeNotifier {
  static Coords? _coords;
  Coords? get coords => _coords;

  static WeatherData? _weatherData;
  WeatherData? get weatherData => _weatherData;

  Current? _current;
  Current? get current => _current;

  List<Daily>? _daily;
  List<Daily>? get daily => _daily;

  TextEditingController cityController = TextEditingController();

  Future<WeatherData?> setUp({required String cityName}) async {
    _coords = await WeatherApi.getCoords(cityName);
    _weatherData = await WeatherApi.getWeather(coords);
    _current = weatherData?.current;
    _daily = weatherData?.daily;
    setDailyDay();
    return weatherData;
  }

  void setCity(BuildContext context, {String? cityName}) async {
    cityName = cityController.text;

    await setUp(cityName: cityName).then(
      (value) => Navigator.of(context).pop(),
    );
    notifyListeners();
  }

  final double _kelvin = -273.15;

  int? _currentTemp;
  int? get currentTemp => _currentTemp;

  int setCurrentTemp() {
    _currentTemp = ((current?.temp ?? -_kelvin) + _kelvin).round();
    return currentTemp ?? 0;
  }

  int? _currentMinTemp;
  int? get currentMinTemp => _currentMinTemp;

  int setCurrentMinTemp() {
    _currentMinTemp = ((daily?[0].temp?.min ?? -_kelvin) + _kelvin).round();

    return currentMinTemp ?? 0;
  }

  int? _currentMaxTemp;
  int? get currentMaxTemp => _currentMaxTemp;

  int setCurrentMaxTemp() {
    _currentMaxTemp = ((daily?[0].temp?.max ?? -_kelvin) + _kelvin).round();

    return currentMaxTemp ?? 0;
  }

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  String? _currentStatus;
  String? get currentStatus => _currentStatus;

  String setCurrentStatus() {
    _currentStatus = current?.weather?[0].description;
    return capitalize(currentStatus ?? 'error');
  }

  String? _currentTime;
  String? get currentTime => _currentTime;

  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    _currentTime = DateFormat('HH:mm').format(setTime);
    return _currentTime ?? 'Error';
  }

  String? _currentSunsetTime;
  String? get currentSunsetTime => _currentSunsetTime;

  String setSunsetTime() {
    final getSunsetTime =
        (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunsetTime =
        DateTime.fromMillisecondsSinceEpoch(getSunsetTime * 1000);
    _currentSunsetTime = DateFormat('HH:mm').format(setSunsetTime);
    return _currentSunsetTime ?? 'Error';
  }

  String? _currentSunriceTime;
  String? get currentSunriceTime => _currentSunriceTime;

  String setSunriseTime() {
    final getSunriceTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setSunriceTime =
        DateTime.fromMillisecondsSinceEpoch(getSunriceTime * 1000);
    _currentSunriceTime = DateFormat('HH:mm').format(setSunriceTime);
    return _currentSunriceTime ?? 'Error';
  }

  List _values = [];
  List get values => _values;
  double setValues(int index) {
    _values.add(current?.windSpeed ?? 0);
    _values.add(((current?.feelsLike ?? -_kelvin) + _kelvin).roundToDouble());
    _values.add((current?.humidity ?? 0.0) / 1);
    _values.add((current?.visibility ?? 0) / 1000);

    return values[index] ?? 0.0;
  }

  int? _dailyNightTemp;
  int? get dailyNightTemp => _dailyNightTemp;

  int? _dailyDayTemp;
  int? get dailyDayTemp => _dailyDayTemp;

  int setNightTemp(int index) {
    _dailyNightTemp =
        ((_daily?[index].temp?.night ?? -_kelvin) + _kelvin).round();
    return dailyNightTemp ?? 0;
  }

  int setDayTemp(int index) {
    _dailyDayTemp = ((_daily?[index].temp?.day ?? -_kelvin) + _kelvin).round();

    return dailyDayTemp ?? 0;
  }

  final String _iconUrlPath = 'http://openweathermap.org/img/wn/';

  String setDailyIcon(int index) {
    final String getIcon = '${_daily?[index].weather?[0].icon}';
    final String setIcon = _iconUrlPath + getIcon + '.png';
    return setIcon;
  }

  final List<String> _date = [];
  List<String> get date => _date;

  void setDailyDay() {
    // Цикл for
    // Добавление в лист обработанных дней

    for (var i = 0; i < daily!.length; i++) {
      try {
        if (i == 0 && _date.isNotEmpty) _date.clear();

        if (i == 0) {
          _date.add('Сегодня');
        } else {
          final getDay = (daily![i].dt!) * 1000;
          final itemDate = DateTime.fromMillisecondsSinceEpoch(getDay);
          _date.add(capitalize(DateFormat('EEEE', 'ru').format(itemDate)));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  String _getWeatherBg = Bg.clearBg;
  String get getWeatherBg => _getWeatherBg;

  String setWeatherTheme() {
    // int id = _current?.weather?[0].id ?? -1;
    int id = 701;

    if (id == -1 || _current?.sunset == null || _current?.dt == null)
      return Bg.clearBg;

    try {
      if (_current!.sunset! > _current!.dt!) {
        if (id >= 200 && id <= 531) {
          _getWeatherBg = Bg.rainBg;
          AppColors.textColor = const Color(0xFF030708);
          AppColors.valueColor = const Color(0xFF002C25);
          AppColors.blurContainer = const Color.fromRGBO(106, 141, 135, 0.5);
        } else if (id >= 600 && id <= 622) {
          _getWeatherBg = Bg.snowBg;
          AppColors.textColor = const Color(0xFF030708);
          AppColors.valueColor = const Color(0xFF002C25);
          AppColors.blurContainer = const Color.fromRGBO(109, 160, 192, 0.5);
        } else if (id >= 701 && id <= 781) {
          _getWeatherBg = Bg.fogBg;
          AppColors.textColor = const Color(0xFF323232);
          AppColors.valueColor = const Color(0xFFFFFFFF);
          AppColors.blurContainer = const Color.fromRGBO(142, 141, 141, 0.5);
        } else if (id >= 801 && id <= 804) {
          _getWeatherBg = Bg.cloudyBg;
          AppColors.textColor = const Color(0xFF001C39);
          AppColors.valueColor = const Color(0xFFFFFFFF);
          AppColors.blurContainer = const Color.fromRGBO(140, 155, 170, 0.5);
        } else {
          _getWeatherBg = Bg.clearBg;
          AppColors.textColor = const Color(0xFF002535);
          AppColors.valueColor = const Color(0xFFFFFFFF);
          AppColors.blurContainer = const Color.fromRGBO(80, 130, 155, 0.3);
        }
      } else {
        if (id >= 200 && id <= 531) {
          _getWeatherBg = Bg.rainNightBg;
          AppColors.textColor = const Color(0xFFC6C6C6);
          AppColors.valueColor = const Color(0xFFFFFFFF);
          AppColors.blurContainer = const Color.fromRGBO(35, 35, 35, 0.5);
        } else if (id >= 600 && id <= 622) {
          _getWeatherBg = Bg.snowNightBg;
          AppColors.textColor = const Color(0xFFE6E6E6);
          AppColors.valueColor = const Color(0xFFF9DADA);
          AppColors.blurContainer = const Color.fromRGBO(12, 23, 27, 0.5);
        } else if (id >= 701 && id <= 781) {
          _getWeatherBg = Bg.fogNightBg;
          AppColors.textColor = const Color(0xFFFFFFFF);
          AppColors.valueColor = const Color(0xFF999999);
          AppColors.blurContainer = const Color.fromRGBO(35, 35, 35, 0.5);
        } else if (id >= 801 && id <= 804) {
          _getWeatherBg = Bg.cloudyNightBg;
          AppColors.textColor = const Color(0xFFE2E2E2);
          AppColors.valueColor = const Color(0xFF7E8386);
          AppColors.blurContainer = const Color.fromRGBO(12, 23, 27, 0.5);
        } else {
          _getWeatherBg = Bg.clearNightBg;
          AppColors.textColor = const Color(0xFFFFFFFF);
          AppColors.valueColor = const Color(0xFF51DAFF);
          AppColors.blurContainer = const Color.fromRGBO(47, 97, 148, 0.5);
        }
      }
    } catch (e) {
      return Bg.clearBg;
    }

    return _getWeatherBg;
  }
}
