import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';


import '../../../../util/constants.dart';
import '../../../../utils.dart';

class WelcomeRichText extends StatelessWidget {
  const WelcomeRichText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: SafeGoogleFont(
          'Montserrat',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.3,
          color: AppColors.gray,
        ),
        children: [
          const TextSpan(
            text: 'By creating an account, you are agreeing to our ',
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            text: 'Terms of Service',
            style: SafeGoogleFont(
              'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: AppColors.accent,
            ),
          ),
          const TextSpan(
            text: ' and ',
          ),
          TextSpan(
            text: 'Privacy Policy',
            recognizer: TapGestureRecognizer()..onTap = () {},
            style: SafeGoogleFont(
              'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: AppColors.accent,
            ),
          ),
          const TextSpan(
            text:
                '. You also agree to receive product-related marketing emails, which you can unsubscribe from at any time',
          ),
        ],
      ),
    );
  }
}
