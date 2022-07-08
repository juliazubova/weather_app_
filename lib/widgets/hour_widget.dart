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

    return SizedBox(
      height: 230,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 23,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: index == 0 ? const EdgeInsets.only(left: 10) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 100 - 3 * snapshot!.forecast!.forecastday![0].hour![index].tempC!,
                    color: whiteColor,
                  ),
                  Container(
                      width: 70,
                      height: 3 * snapshot.forecast!.forecastday![0].hour![index].tempC!,
                      color: lightOrangeColor,
                      child: Center(
                        child: Text('${snapshot.forecast!.forecastday![0].hour![index].tempC}°',
                            style: TextStyle(fontSize: 16, color: whiteColor) ),
                      )
                  ),
                  index < 11
                      ? Text('${index + 1} am', style: TextStyle(fontSize: 20, color: primaryColor))
                      : index == 11
                      ? Text('${index + 1} pm', style: TextStyle(fontSize: 20, color: primaryColor))
                      : Text('${index - 11} pm', style: TextStyle(fontSize: 20, color: primaryColor)),
                  const SizedBox(height: 5),
                  // Container(
                  //     width: 70,
                  //     height: 5 * snapshot.forecast!.forecastday![0].hour![index].precipMm!,
                  //     color: blueColor,
                  //     child: Center(
                  //       child: Text('${snapshot.forecast!.forecastday![0].hour![index].precipMm}° mm',
                  //         style: TextStyle(fontSize: 16, color: blackColor),),
                  //     )
                  // ),
                  // Container(
                  //   width: 70,
                  //   height: 10 - 5 * snapshot.forecast!.forecastday![0].hour![index].precipMm!,
                  //   color: whiteColor,
                  // ),
                  // const SizedBox(height: 5),
                  Image.network(
                      'https://${(snapshot.forecast!.forecastday![0].hour![index].condition!.icon).toString().substring(2)}',
                      scale: 1),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
