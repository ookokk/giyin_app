import 'package:f6_bootcamp/src/constants/color.dart';
import 'package:f6_bootcamp/src/constants/text_style.dart';
import 'package:flutter/material.dart';

class CategoriesWardrobeScreen extends StatelessWidget {
  const CategoriesWardrobeScreen({Key? key}) : super(key: key);
  static const List<Tab> myTabs = <Tab>[
    Tab(text: '1'),
    Tab(text: '2'),
    Tab(text: '3'),
    Tab(text: '4'),
    Tab(text: '5'),
    Tab(text: '6'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CustomColors.kDarkBlue,
            bottom: TabBar(
              tabs: myTabs,
            ),
          ),
          body: TabBarView(
            children: myTabs.map((Tab tab) {
              final String label = tab.text!.toLowerCase();
              return Center(
                child: Text("this is $label tab", style: kMediumLargeBText),
              );
            }).toList(),
          ),
        ));
  }
}
