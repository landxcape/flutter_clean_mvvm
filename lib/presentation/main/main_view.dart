// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/presentation/main/home_page.dart';
import 'package:flutter_clean_mvvm/presentation/main/notifications_page.dart';
import 'package:flutter_clean_mvvm/presentation/main/search_page.dart';
import 'package:flutter_clean_mvvm/presentation/main/settings_page.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];

  String _title = AppStrings.home;
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: pages[],
    );
  }
}
