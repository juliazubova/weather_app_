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
    var windSpeed = snapshot!.current?.windKph!.toInt();
    var windDir = snapshot.current!.windDir!;
    var visibility = snapshot.forecast!.forecastday![0].day!.avgvisKm;
    var humidity = snapshot.current?.humidity!.toInt();
    var pressure = snapshot.current?.pressureMb!.toInt();
    var uv = snapshot.current?.uv;
    var sunset = snapshot.forecast!.forecastday![0].astro!.sunset;
    var sunrise = snapshot.forecast!.forecastday![0].astro!.sunrise;

    return Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_circle_right_rounded, size: 30, color: purpleColor),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${windSpeed} km/h winds from the ${windDir}.', style: TextStyle(fontSize: 20)),
                    Text('Visibility ${visibility} kilometers.', style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.water_drop, size: 30, color: blueColor),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Humidity ${humidity}%.', style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.speed_rounded, size: 30, color: greenColor),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pressure ${pressure} hPa.', style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.wb_twilight_outlined, size: 30, color: lightOrangeColor),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sunrise ${sunrise} \u{2192} Sunset ${sunset}.', style: TextStyle(fontSize: 20)),
                  ],
                )
              ],
            ),
          ],
        )
    );
  }
}
