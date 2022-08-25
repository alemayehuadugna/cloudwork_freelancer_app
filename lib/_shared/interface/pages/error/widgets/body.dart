import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'error_text.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 500);
  bool startAnimation = false;
  bool startBroke = false;
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 250), vsync: this)
          ..addListener(() {
            setState(() {});
          });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        startAnimation = true;
      });
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLargerThanMobile =
        ResponsiveWrapper.of(context).isLargerThan(TABLET);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StaggeredGrid.count(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: isLargerThanMobile ? 2 : 1,
            children: [
              const ErrorText(),
              if (isLargerThanMobile)
                SizedBox(
                  width: 641,
                  height: 400,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Shadow
                      AnimatedPositioned(
                        duration: duration,
                        top: 0,
                        left: startAnimation ? 0 : 50,
                        child: AnimatedOpacity(
                          opacity: startAnimation ? 1 : 0.3,
                          duration: duration,
                          child: SvgPicture.asset(
                            "assets/icons/Group 64.svg",
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      // Cycle
                      AnimatedPositioned(
                        duration: duration,
                        bottom: 0,
                        left: startAnimation ? 130 : 0,
                        child: AnimatedOpacity(
                          duration: duration,
                          opacity: startAnimation ? 1 : 0,
                          child: SizedBox(
                            height: 310,
                            width: 528,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  // duration: Duration(milliseconds: 200),
                                  bottom: 7,
                                  left: 230 + _animationController.value * 90,
                                  child: SvgPicture.asset(
                                    "assets/icons/cycle_part_2.svg",
                                    height: 142,
                                    width: 142,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Transform.rotate(
                                    angle: (_animationController.value * 5) *
                                        (pi / 180),
                                    child: SvgPicture.asset(
                                      "assets/icons/cycle_part_1.svg",
                                      height: 287,
                                    ),
                                  ),
                                ),
                                // Bottom Line
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: SvgPicture.asset(
                                    "assets/icons/line.svg",
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
