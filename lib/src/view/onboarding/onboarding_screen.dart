import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constants/default_padding.dart';
import '../../constants/text_style.dart';
import 'intro_page1.dart';
import 'intro_page2.dart';
import 'intro_page3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        onLastPage = (index == 2);
                      });
                    },
                    children: const [
                      IntroPage1(),
                      IntroPage2(),
                      IntroPage3(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(2);
                          },
                          child: Text(
                            "Skip",
                            style: kMediumLargeWText,
                          ),
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                        SmoothPageIndicator(controller: _controller, count: 3),
                        const SizedBox(
                          width: 28,
                        ),
                        onLastPage
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/auth');
                                },
                                child: Text("Done", style: kMediumLargeWText),
                              )
                            : GestureDetector(
                                onTap: () {
                                  _controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: Text("Next", style: kMediumLargeWText),
                              )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
