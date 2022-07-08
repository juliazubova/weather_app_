import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/widgets/main_screen_model.dart';
import 'package:weathet_app/utils/constants.dart';

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
                //fontFamily: 'Montserrat',
                color: blackColor,
              )
          ),
          Row(
            children: [
              Image.network(url, scale: 0.8),
              Column(children: [
                Text('$temp°', style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
                Text('Feels like $feelTemp°', style: TextStyle(fontSize: 20, color: greyColor)),
              ],)
            ],
          ),
        ],
      ),
    );
  }
}
