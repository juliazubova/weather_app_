import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:weathet_app/widgets/main_screen_model.dart';
import 'package:weathet_app/widgets/header_widget.dart';
import 'package:weathet_app/widgets/right_now_widget.dart';
import 'package:weathet_app/widgets/hour_widget.dart';
import 'package:weathet_app/widgets/indicators_widget.dart';
import 'package:weathet_app/widgets/week_widget.dart';
import 'package:weathet_app/utils/constants.dart';

import 'package:carousel_slider/carousel_slider.dart';

class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: model.forecastObject?.location?.name != null && model.loading == false
          ? _ViewWidget()
          : const Center(child: SpinKitRing(color: orangeColor, size: 70)),
    );
  }
}

class _ViewWidget extends StatelessWidget {
  const _ViewWidget({Key? key}) : super(key: key);

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
                      IndicatorsWidget(),
                      SizedBox(height: 15),
                      HourWidget(),
                      WeekWidget(),
                      SizedBox(height: 15,),
                    ]
                )
              ] ,
            ),
            const HeaderWidget(),
          ],)
    );
  }
}
