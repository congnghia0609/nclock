/*
 * Copyright 2020 nghiatc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

///
/// @author nghiatc
/// @since Aug 29, 2020

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nclock/models/my_theme_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'clock_painter.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.surface, shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: kShadowColor.withOpacity(0.14),
                  blurRadius: 64,
                ),
              ]),
              child: Transform.rotate(
                angle: -pi / 2,
                child: CustomPaint(
                  painter: ClockPainter(context, _dateTime),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: Consumer<MyThemeModel>(
            builder: (context, theme, child) => GestureDetector(
              onTap: () => theme.changeTheme(),
              child: SvgPicture.asset(
                theme.isLightTheme
                ? "assets/icons/Sun.svg"
                : "assets/icons/Moon.svg",
                height: 24,
                width: 24,
                color: Theme.of(context).primaryColor,
              ),
            )
          ),
        ),
      ],
    );
  }
}
