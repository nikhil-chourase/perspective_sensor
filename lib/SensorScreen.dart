import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';


class SensorScreen extends StatefulWidget {

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  AccelerometerEvent acceleration = AccelerometerEvent(0.0, 0.0, 0.0);
  late StreamSubscription<AccelerometerEvent> _streamSubscription ;

  int planetMotionSensitivity = 4;
  int bgMotionSensitivity = 2;

  @override
  void initState() {
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        acceleration = event;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: acceleration.y * bgMotionSensitivity,
              bottom: acceleration.y * -bgMotionSensitivity,
              right: acceleration.x * -bgMotionSensitivity,
              left: acceleration.x * bgMotionSensitivity,
              child: Align(
                child: Image.asset(
                  'images/space1.jpg',
                  height: 1920,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: acceleration.y * planetMotionSensitivity,
              bottom: acceleration.y * -planetMotionSensitivity,
              right: acceleration.x * -planetMotionSensitivity,
              left: acceleration.x * planetMotionSensitivity,
              child: Align(
                child: Image.asset(
                  'images/earth.png',
                  width: 250,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
