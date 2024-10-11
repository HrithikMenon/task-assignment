import 'dart:async';

import 'package:dribble_ui/core/theme/colors.dart';
import 'package:dribble_ui/screens/billing_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<String> textList = [
    'Goal-setting,Dedication,Workflow,Efficiency,Concentration,Discipline,Balance,Productivity,Time-manager,Perfomance,Focus.'
  ].first.split(',');

  int highlightedIndex = 0;
  Timer? timer;

  double starPosition = 0.0;
  double rotationAngle = 0.0;
  int starIndex = 0;

  @override
  void initState() {
    super.initState();

    startColorChangeAndMoveStar();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startColorChangeAndMoveStar() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        highlightedIndex = (highlightedIndex + 1) % textList.length;
        starIndex = (starIndex + 1) % textList.length;

        starPosition = starIndex * 50.0;
        rotationAngle += 0.5;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainThemeColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(textList.length, (index) {
                          return Text(
                            textList[index],
                            style: TextStyleClass.splashScreenTextStyle
                                .copyWith(
                                    height: 1,
                                    color: index == highlightedIndex
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.2)),
                          );
                        }),
                      ),
                    ],
                  ),
                )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 75,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BillingScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      side: const BorderSide(color: Colors.black, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Get Started',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: starPosition,
            right: 0,
            child: AnimatedRotation(
              duration: const Duration(seconds: 1),
              turns: rotationAngle,
              child: Image.asset(
                'assets/starburst.png',
                color: const Color.fromARGB(255, 255, 191, 0),
                width: 500,
                height: 500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
