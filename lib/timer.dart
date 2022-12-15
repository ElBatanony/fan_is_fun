import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

import 'package:quiver/async.dart';

class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  // late Timer _timer;
  int _start = 80;
  int _current = 0;
  int _minutes = 0;
  int _seconds = 0;

/*
  void startTimer() {
    print("i started");
    const oneSec = const Duration(seconds: 1);
    // ignore: unnecessary_new
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            print(" start - $_start");
            _minutes = Duration(seconds: _start).inMinutes;
            _seconds = _start % 60;
          });
        }
      },
    );
  }
*/

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
        print("current - $_current");
        _minutes = Duration(seconds: _current).inMinutes;
        _seconds = _current % 60;
      });
    });

    sub.onDone(() {
      print("Done");
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Timer test")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Waiting",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Videocall with Marat Khusnutdinov",
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "$_minutes minutes $_seconds seconds",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Call will last for 2 minutes, your order is 2, waiting time - 2 minutes",
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                height: 50,
              ),
              Lottie.asset('waiting.json', width: 300, height: 300),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: Text("Press"))
            ],
          ),
        ),
      ),
    );
  }
}
