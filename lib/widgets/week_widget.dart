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
        height: 275,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // child: Align(
        //   alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This week',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 35,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(
                height: 230,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 2,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return Column(children: [Container(
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                Stack(
                                  alignment: Alignment.centerRight,
                                  children: [
                                    Container(
                                      color: whiteColor,
                                      height: 40,
                                      width: 60 - 0.6 * snapshot!.forecast!.forecastday![index + 1].day!.avghumidity!.toInt(),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: blueColor,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5))
                                      ),
                                      height: 40,
                                      width: snapshot.forecast!.forecastday![index + 1].day!.avghumidity! == 0 ? 0
                                          : 40 + 0.6 * snapshot.forecast!.forecastday![index + 1].day!.avghumidity!,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(' ${snapshot.forecast!.forecastday![index + 1].day!.avghumidity!.toInt()}%',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: whiteColor),)
                                      ),
                                    ),
                                    Image.network(
                                        'https://${(snapshot.forecast!.forecastday![index + 1].day!.condition!.icon).toString().substring(2)}',
                                        scale: 1.4),
                                  ],
                                ),
                                Text('${snapshot.forecast!.forecastday![index + 1].date}'.substring(8, 10) + '.'
                                    + '${snapshot.forecast!.forecastday![index + 1].date}'.substring(5, 7),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400)),

                                SizedBox(width: 5,),
                                Container(
                                    height: 40,
                                    width: 40,
                                    color: lightOrangeColor,
                                    child: Center(
                                      child: Text('${snapshot.forecast!.forecastday![index + 1].day!.mintempC!.toInt()}°',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: whiteColor,)),)
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: orangeColor,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(5))
                                    ),
                                    height: 40,
                                    width: 2.5 * snapshot.forecast!.forecastday![index + 1].day!.maxtempC!,
                                    child: Center(
                                      child: Text('${snapshot.forecast!.forecastday![index + 1].day!.maxtempC!.toInt()}°',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: whiteColor,
                                        ),),
                                    )
                                ),
                              ]
                          )
                      )]
                      );
                    }
                )
            )
          ],
        )
    );
  }
}

