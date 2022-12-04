import 'package:flutter/material.dart';
import 'package:quantam/News/Presentation/Screens/SearchNews_Screen.dart';
import 'package:quantam/News/Presentation/Screens/TopHeadlines_Screen.dart';
import 'package:quantam/News/utils/colorPallete.dart';

import '../../utils/CustomTextStyle.dart';
import '../../utils/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title:
              Text(StringFiles.heading, style: AppTextStyle().headingStyle()),
          backgroundColor: AppColors.appBackgroundColor,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100.0), //
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.search, color: AppColors.tabIconcColor),
                ),
                Tab(
                  icon: Icon(Icons.newspaper, color: AppColors.tabIconcColor),
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [SearchNewsScreen(), TopHeadLinesScreen()],
        ),
      ),
    );
  }
}
