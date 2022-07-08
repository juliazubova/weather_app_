import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/widgets/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

class HourWidget extends StatelessWidget {
  const HourWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;

    return Padding(
        padding: EdgeInsets.only(left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today',
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 35,
                fontFamily: 'Montserrat',
              ),
            ),
            Text('${snapshot!.current?.condition!.text}',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 20,
                  //fontFamily: 'Montserrat',
                  color: blackColor,
                )
            ),
            SizedBox(
                height: 200,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: 23,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index){
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 120 - 4.0 * snapshot.forecast!.forecastday![0].hour![index].tempC!.toInt(),
                              color: whiteColor,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: lightOrangeColor,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5))
                              ),
                              width: 40,
                              height: 4.0 * snapshot.forecast!.forecastday![0].hour![index].tempC!.toInt(),
                              child: Column(
                                children: [
                                  Text('${(snapshot.forecast!.forecastday![0].hour![index].tempC!).toInt()}°',
                                      style: TextStyle(fontSize: 20, color: whiteColor, fontWeight: FontWeight.w600) ),
                                ],
                              ),
                            ),
                            index < 11
                                ? Text('${index + 1}am', style: TextStyle(fontSize: 15, color: primaryColor, fontWeight: FontWeight.w400))
                                : index == 11
                                ? Text('${index + 1}pm', style: TextStyle(fontSize: 15, color: primaryColor, fontWeight: FontWeight.w400))
                                : Text('${index - 11}pm', style: TextStyle(fontSize: 15, color: primaryColor, fontWeight: FontWeight.w400)),
                            // const SizedBox(height: 5),
                            Image.network('https://${(snapshot.forecast!.forecastday![0].hour![index].condition!.icon).toString().substring(2)}',
                                scale: 1.8),
                          ],
                        ),
                      );
                    }
                )
            )
          ],
        )
    );
  }
}
