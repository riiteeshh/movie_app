import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/pages/home_page.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    Text('tickets'),
    Text('Saved')
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        // padding: const EdgeInsets.symmetric(vertical: 5),
        height: MediaQuery.of(context).size.height * 0.09,
        child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.movie_filter_outlined,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.tickets), label: 'Tickets'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_outline), label: 'Saved'),
            ]),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
