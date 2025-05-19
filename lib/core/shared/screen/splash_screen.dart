import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_ease/core/config/extension.dart';
import 'package:quran_ease/core/config/route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/quran.svg',
            ),
            const SizedBox(height: 22),
            Text(
              'Quran Ease',
              style: context.text.bodyLarge?.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: context.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Learn Quran and Recite Everyday',
              style: context.text.bodyLarge?.copyWith(
                fontSize: 16,
                color: context.greyText,
              ),
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                MyRouter.routeHome,
                (route) => false,
              ),
              child: Container(
                width: context.dw * 0.4,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.primaryShade100,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Get Started',
                      style: context.text.labelMedium?.copyWith(
                        fontSize: 16,
                        color: context.primary,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      color: context.primary,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
