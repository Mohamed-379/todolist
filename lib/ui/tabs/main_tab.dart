import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todolist/ui/tabs/completed_tab/completed_tab.dart';
import 'home/home_screen.dart';

class MainTab extends StatefulWidget {
  static const routeName = "TABS";
  const MainTab({super.key});

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  List<Widget> widgets = [
    const HomeScreen(),
    const CompletedTab()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 233, 247),
      body: widgets[index],
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Color.fromARGB(103, 72, 108, 189),
          ),
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
          child: NavigationBarTheme(
            data: const NavigationBarThemeData(
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: Color.fromARGB(89, 59, 89, 152),
              labelTextStyle: MaterialStatePropertyAll(TextStyle(fontFamily: "Ubuntu", fontSize: 14))
            ),
            child: NavigationBar(
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              height: 65,
              selectedIndex: index,
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
              animationDuration: const Duration(milliseconds: 500),
              destinations: [
                const NavigationDestination(
                    icon: Icon(Icons.home_outlined, color: Colors.black,),
                    selectedIcon: Icon(Icons.home, color: Colors.black,),
                    label: "Home",
                ),
                NavigationDestination(
                    icon: SvgPicture.asset('assets/icons/done_1.svg', height: 22,),
                    selectedIcon: SvgPicture.asset('assets/icons/done_0.svg', height: 22,),
                    label: "Completed Tasks"
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
