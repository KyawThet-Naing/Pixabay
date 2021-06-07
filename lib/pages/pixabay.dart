import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/pages/home_page/home.dart';
import 'package:pixabay/pages/setting_page/setting.dart';

class Pixabay extends StatefulWidget {
  const Pixabay({Key? key}) : super(key: key);

  @override
  _PixabayState createState() => _PixabayState();
}

class _PixabayState extends State<Pixabay> {
  int currentPage = 0;
  List<Widget> pages = [Home(), Setting()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) => setState(() => currentPage = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: tr('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: tr('setting'),
          ),
        ],
      ),
    );
  }
}
