import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        const SizedBox(
          height: 28,
        ),
        Expanded(
            child: Image.asset(
          "assets/images/onboarding3.png",
          width: MediaQuery.of(context).size.width * 0.8,
        )),
        Expanded(
          child: Image.asset(
            "assets/images/3.png",
            width: MediaQuery.of(context).size.width * 0.8,
          ),
        )
      ]),
    );
  }
}
