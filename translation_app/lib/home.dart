import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:translation_app/features/archieve/archieve_page.dart';
import 'package:translation_app/features/auth/pages/auth_page.dart';
import 'package:translation_app/features/home/pages/home_page.dart';
import 'package:translation_app/util/constants.dart';
import 'package:translation_app/util/events/change_home_index_event.dart';
import 'package:translation_app/util/events/event_bus.dart';

import 'features/saved_words/pages/saved_words_page.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;

  int _selectedIndex = 0;

  changePage(int idx, {bool fromPageView = false}) {
    setState(() {
      _selectedIndex = idx;

      if (!fromPageView) {
        _pageController.animateToPage(idx,
            duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
      }
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    EventBus.on<ChangeHomeIndexEvent>().listen((event) {
      changePage(event.payload);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (idx) {
          changePage(idx, fromPageView: true);
        },
        children: [
          const MainScreen(),
          SavedWordPage(),
          ArchievePage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentDark.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              backgroundColor: AppColors.light,
              rippleColor: Colors.grey[300]!,
              hoverColor: AppColors.accentDark,
              gap: 8,
              activeColor: AppColors.dark,
              iconSize: 22,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 300),
              tabBackgroundColor: AppColors.accent,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.translate,
                  text: 'Translate',
                ),
                GButton(
                  icon: Icons.bookmark_outline_rounded,
                  text: 'Saved',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: changePage,
            ),
          ),
        ),
      ),
    );
  }
}
