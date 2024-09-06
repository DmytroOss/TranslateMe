import 'package:flutter/material.dart';

import '../../../util/constants.dart';
import '../../../widgets/appbar/appbar.dart';
import '../../../widgets/appbar/appbar_title.dart';
import '../../../widgets/button.dart';
import '../../../widgets/enums/button_type.dart';
import '../../../widgets/enums/fragment_radius.dart';
import '../../../widgets/enums/fragment_size.dart';
import '../../../widgets/inner_text.dart';
import '../../../widgets/translate_banner.dart';
import '../fragments/auth_page/login.dart';
import '../fragments/auth_page/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  int _selectedIdx = 0;
  final PageController _pageController = PageController();
  
  changePage(int idx) {
    setState(() {
      _selectedIdx = idx;

      _pageController.animateToPage(idx,
          duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar.createEmptyAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TranslateBanner(
                  isVertical: true,
                  hasShadow: false,
                  isCentered: true,
                  isTransparent: true),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.accentDark, width: 0),
                      borderRadius: FragmentRadius.full.radius),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Button(
                              type: _selectedIdx == 0
                                  ? ButtonType.primary
                                  : ButtonType.secondary,
                              size: FragmentSize.small,
                              onPressed: () {
                                changePage(0);
                              },
                              child: const InnerText(
                                text: "Sign In",
                              )),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Button(
                              type: _selectedIdx == 1
                                  ? ButtonType.primary
                                  : ButtonType.secondary,
                              size: FragmentSize.small,
                              onPressed: () {
                                changePage(1);
                              },
                              child: const InnerText(
                                text: "Sign Up",
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: changePage,
                  children: const [
                    SingleChildScrollView(child: Login()),
                    SingleChildScrollView(child: Register()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
