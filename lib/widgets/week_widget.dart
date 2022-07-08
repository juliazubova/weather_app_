import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/widgets/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

class WeekWidget extends StatelessWidget {
  const WeekWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;

    return Container(
      height: 200,
      alignment: Alignment.center,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 7,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [//
                    Text('${snapshot!.forecast!.forecastday![index + 1].date}'.substring(8, 10) + '.'
                        + '${snapshot.forecast!.forecastday![index + 1].date}'.substring(5, 7),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500)),
                    Image.network(
                        'https://${(snapshot.forecast!.forecastday![index + 1].day!.condition!.icon).toString().substring(2)}', scale: 1),
                  ],
                ),
                const SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${snapshot.forecast!.forecastday![index + 1].day!.condition!.text}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,),
                    ),
                    Text('${snapshot.forecast!.forecastday![index + 1].day!.maxwindMph} m/s winds',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,),
                    ),
                    const SizedBox(height: 5),
                    Row(children: [
                      Container(
                          height: 40,
                          width: 70,
                          color: lightOrangeColor,
                          child: Center(
                            child: Text('${snapshot.forecast!.forecastday![index + 1].day!.mintempC}°',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: whiteColor,
                              ),),
                          )
                      ),
                      Container(
                          height: 40,
                          width: 6 * snapshot.forecast!.forecastday![index + 1].day!.maxtempC!,
                          color: orangeColor,
                          child: Center(
                            child: Text('${snapshot.forecast!.forecastday![index + 1].day!.maxtempC}°',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: whiteColor,
                              ),),
                          )
                      ),
                    ],),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

