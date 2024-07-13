import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_tesla_app/Model/Typespis.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/battery_Status.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/door_lock.dart';

import 'package:flutter_animated_tesla_app/Screens/Components/temp_details.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/typsi_card.dart';
import 'package:flutter_animated_tesla_app/Screens/Components/tyres.dart';
import 'package:flutter_animated_tesla_app/Screens/contstraint.dart';

import 'package:flutter_animated_tesla_app/Screens/homecontroller.dart';
import 'package:flutter_animated_tesla_app/Screens/tesla_bottom_navigator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class homeScreen extends StatefulWidget {
  homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> with TickerProviderStateMixin {
  final homecontroller _controller = homecontroller();
  late AnimationController _batteryAnimationController;
  late AnimationController _tempAnimationController;

  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationtempshowinfo;
  late Animation<double> _animationCoolGlowinfo;

  late AnimationController _tyreAnimationController;
  late Animation<double> _animationTyre1psi;
  late Animation<double> _animationTyre2psi;
  late Animation<double> _animationTyre3psi;
  late Animation<double> _animationTyre4psi;

  late List<Animation<double>> _tyreAnimation;

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationBattery = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0.0, 0.5));
    _animationBatteryStatus = CurvedAnimation(
        parent: _batteryAnimationController, curve: const Interval(0.6, 1));
    _animationCarShift = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.2, 0.4));
    _animationtempshowinfo = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.45, 0.65));

    _animationCoolGlowinfo = CurvedAnimation(
        parent: _tempAnimationController, curve: const Interval(0.7, 1));
  }

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1700));
    _animationTyre1psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.34, 0.5));
    _animationTyre2psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.5, 0.66));
    _animationTyre3psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.66, 0.82));
    _animationTyre4psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.82, 1));
  }

  @override
  void initState() {
    setupTempAnimation(); // Initialize tempAnimationController first
    setupBatteryAnimation(); // Then initialize batteryAnimationController
    setupTyreAnimation();
    _tyreAnimation=[_animationTyre1psi,_animationTyre2psi,_animationTyre3psi,_animationTyre4psi];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
        _tyreAnimationController
        ]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNaigationBar(
              selectedTab: _controller.selectedBottomTab,
              onTap: (index) {
                if (index == 1)
                  _batteryAnimationController.forward();
                else if (_controller.selectedBottomTab == 1 && index != 1)
                  _batteryAnimationController.reverse(from: 0.7);
                if (index == 2)
                  _tempAnimationController.forward();
                else if (_controller.selectedBottomTab == 2 && index != 2)
                  _tempAnimationController.reverse(from: 0.4);
                  if(index==3){
                    _tyreAnimationController.forward();
                  }else if(_controller.selectedBottomTab==3 && index!=3)
                  _tyreAnimationController.reverse();
                _controller.showTyreController(index);
                _controller.tyreStatusController(index);
                _controller.onBottomNavigatorTabChange(index);
              },
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                        duration: defaualtduration,
                        right: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaualtduration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: _controller.isRightdoorlock,
                              press: _controller.updateRightdoorlock),
                        )),
                    AnimatedPositioned(
                        duration: defaualtduration,
                        left: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.05
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaualtduration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: _controller.isleftdoorlock,
                              press: _controller.updateleftdoorlock),
                        )),
                    AnimatedPositioned(
                        duration: defaualtduration,
                        top: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.25
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaualtduration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: _controller.istopdoorlock,
                              press: _controller.updatetopdoorlock),
                        )),
                    AnimatedPositioned(
                        duration: defaualtduration,
                        bottom: _controller.selectedBottomTab == 0
                            ? constrains.maxWidth * 0.25
                            : constrains.maxWidth / 2,
                        child: AnimatedOpacity(
                          duration: defaualtduration,
                          opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                          child: DoorLock(
                              isLock: _controller.isbottomdoorlock,
                              press: _controller.updatebottomdoorlock),
                        )),
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(
                          constrains: constrains,
                        ),
                      ),
                    ),
                    Positioned(
                        height: constrains.maxHeight,
                        width: constrains.maxWidth,
                        top: 60 * (1 - _animationtempshowinfo.value),
                        child: Opacity(
                            opacity: _animationtempshowinfo.value,
                            child: Tempdetails(controller: _controller))),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlowinfo.value),
                      child: AnimatedSwitcher(
                          duration: defaualtduration,
                          child: _controller.isCoolSelected
                              ? Image.asset(
                                  'assets/images/Cool_glow_2.png',
                                  key: UniqueKey(),
                                )
                              : Image.asset('assets/images/Hot_glow_4.png',
                                  key: UniqueKey())),
                      width: 200,
                    ),
                    if (_controller.isShowTyre) ...tyres(constrains),
                    if (_controller.isShowTyreStatus)
                      GridView.builder(
                        itemCount: 4,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: defaualtpadding,
                            crossAxisSpacing: defaualtpadding,
                            childAspectRatio:
                                constrains.maxWidth / constrains.maxHeight,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) => ScaleTransition(
                          scale: _tyreAnimation[index],
                          child: typepsicard(
                            isBottomTwotyre: index > 1,
                            tyrepsi: demoPsiList[index],
                          ),
                        ),
                      )
                  ],
                );
              }),
            ),
          );
        });
  }
}
