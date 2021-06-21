
import 'package:flutter/material.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_bloc/pages/home_page_with_bloc.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_provider/pages/home_page_with_provider.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_state_notifier/pages/home_page_with_state_notifier.dart';
import 'package:flutter_clean_arquitect02/layers/presentacion/home_with_states_rebuilder/pages/home_page_with_state_rebuilder.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _appPages = <Widget>[
    HomePageWithBloc(),
    HomePageWithProvider(),
    HomePageWithStateNotifier(),
    HomePageWithStatesRebuilder()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _appPages,
      ),
      bottomNavigationBar:  _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: 'Bloc'
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.business),
          label: 'Provider',
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.school),
          label: 'StatesRebulder',
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.notifications_active),
          label: 'StateNotifier',
        ),
        const BottomNavigationBarItem(
          icon: const Icon(Icons.notifications),
          label: 'ValueNotifier',
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey.shade500,
      type: BottomNavigationBarType.shifting,
      onTap: _onItemTapped,
    );
  }
}