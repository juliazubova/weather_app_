import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/widgets/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

class IndicatorsWidget extends StatelessWidget {
  const IndicatorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var windSpeed = snapshot!.current?.windKph;
    var humidity = snapshot.current?.humidity;
    var pressure = snapshot.current?.pressureMb;
    var uv = snapshot.current?.uv;
    var sunset = snapshot.forecast!.forecastday![0].astro!.sunset;
    var sunrise = snapshot.forecast!.forecastday![0].astro!.sunrise;

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: bgGreyColor,
            elevation: 0,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customListTile(
                    text: snapshot.current!.windDir!,
                    first: 'Wind speed:',
                    second: ' $windSpeed km/h',
                    icon: Icons.arrow_circle_left_rounded,
                    iconColor: Colors.blue,
                  ),
                  customListTile(
                    first: 'Humidity:',
                    second: ' $humidity %',
                    icon: Icons.water_drop_outlined,
                    iconColor: blueColor,
                  ),
                  customListTile(
                    first: 'Pressure:',
                    second: ' $pressure hPa',
                    icon: Icons.speed,
                    iconColor: Colors.red[300]!,
                  ),
                  customListTile(
                    first: 'UV index:',
                    second: ' $uv %',
                    icon: Icons.light_mode_outlined,
                    iconColor: orangeColor,
                  ),
                  customListTile(
                    first: 'Sunrise:',
                    second: ' $sunrise',
                    icon: Icons.sunny,
                    iconColor: pinkColor,
                  ),
                  customListTile(
                    first: 'Sunset:',
                    second: ' $sunset',
                    icon: Icons.shield_moon_outlined,
                    iconColor: purpleColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
