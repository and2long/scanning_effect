import 'package:flutter/material.dart';
import 'package:scanning_effect/recognition_effect_page.dart';
import 'package:scanning_effect/qrcode_effect_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual Effect',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  final _pageController = PageController();
  List<String> _titles = ['QRCode', 'Recognition'];
  List<IconData> _icons = [Icons.crop_free, Icons.adjust];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          QRCodeEffectPage(),
          RecognitionEffectPage(),
        ],
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: List.generate(
          _titles.length,
          (index) {
            return BottomNavigationBarItem(
              icon: Icon(_icons[index]),
              label: _titles[index],
            );
          },
        ),
        currentIndex: _tabIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        // selectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
    );
  }
}
