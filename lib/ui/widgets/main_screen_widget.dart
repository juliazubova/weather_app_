import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/ui/widgets/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: model.forecastObject?.location?.name != null && model.loading == false
          ? _ViewWidget()
          : const Center(child: SpinKitCubeGrid(color: Colors.blue, size: 80)),
    );
  }
}

class _ViewWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var city = snapshot!.location?.name;

    return SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children:[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 70),
                      RightNowWidget(),
                      // SizedBox(height: 5),
                      CarouselWidget(),
                      SizedBox(height: 15),
                      IndicatorsWidget(),
                      // SizedBox(height: 15,),
                      // WeekWidget(),
                    ]
                )
              ] ,
            ),
            const HeaderWidget(),
        ],)
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var city = snapshot!.location?.name;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: ((value) => model.cityName = value),
              onSubmitted: (_) => model.onSubmitSearch(),
              decoration: InputDecoration(
                filled: true,
                fillColor: bgGreyColor.withAlpha(235),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.blue.withAlpha(135)),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: model.onSubmitSearch,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: bgGreyColor.withAlpha(235),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(12),
              iconSize: 26,
              onPressed: model.onSubmitLocate,
              icon: const Icon(Icons.location_on_outlined, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

class RightNowWidget extends StatelessWidget {
  const RightNowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var city = snapshot!.location?.name;
    var temp = snapshot.current?.tempC!.round();
    var feelTemp = snapshot.current?.feelslikeC;
    var condition = snapshot.current?.condition!.text;
    var url = 'https://${((snapshot.current!.condition!.icon).toString().substring(2)).replaceAll("64", "128")}';

    return Padding(
      padding: EdgeInsets.only(left: 10),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Right now in $city',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 35,
              fontFamily: 'Montserrat',
            ),
          ),
          Text('$condition',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Montserrat',
                color: blackColor,
              )
          ),
          Row(
            children: [
              Image.network(url, scale: 0.8),
              Column(children: [
                appText(size: 60, text: '$temp°', isBold: FontWeight.bold),
                appText(size: 20, text: 'Feels like $feelTemp°', color: greyColor),
              ],)
            ],
          ),
        ],
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    return SizedBox(
      height: 170,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 23,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: index == 0 ? const EdgeInsets.only(left: 20) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  index < 11
                      ? appText(
                          size: 20,
                          text: '${index + 1} am',
                          color: primaryColor)
                      : index == 11
                          ? appText(
                              size: 20,
                              text: '${index + 1} pm',
                              color: primaryColor)
                          : appText(
                              size: 20,
                              text: '${index - 11} pm',
                              color: primaryColor),
                  const SizedBox(height: 10),
                  Image.network(
                      'https://${(snapshot!.forecast!.forecastday![0].hour![index].condition!.icon).toString().substring(2)}',
                      scale: 1.2),
                  const SizedBox(height: 5),
                  appText(
                    size: 20,
                    text:
                        '${snapshot.forecast!.forecastday![0].hour![index].tempC}°',
                  ),
                  const SizedBox(height: 5),
                  appText(
                    size: 20,
                    text:
                    '${snapshot.forecast!.forecastday![0].hour![index].precipMm} mm',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

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
                    icon: Icons.air,
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
