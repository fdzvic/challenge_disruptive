import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/dashboard_controller.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/dashboard_state.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.pageController,
    required this.pageState,
  });

  final DashboardController pageController;
  final DashboardState pageState;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.pageState.selectedIndexScreen ?? 0,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    widget.pageController.setSelectIndexScreen(index);
  }
}
