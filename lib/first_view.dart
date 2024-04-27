import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math' as math;

class FirstView extends StatefulWidget {
  FirstView({super.key});

  @override
  State<StatefulWidget> createState() => _FirstView();
}

class _FirstView extends State<FirstView> with TickerProviderStateMixin {
  late AnimationController _playController;
  late AnimationController _textController;
  Timer? _timer;
  int _seconds = 0;
  bool isPlay = true;

  @override
  void initState() {
    super.initState();
    _playController = AnimationController(
      duration: Duration(milliseconds: 1000),
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
    )..repeat(reverse: true);
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
    )..stop();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ScaleTransition(
          scale: Tween(begin: 1.0, end: 1.2).animate(_textController),
          child: _timerText(context)),
      SizedBox(height: size.height * 0.02),
      // Center(child:
          ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.1).animate(_playController),
              child: Stack(children: [
                Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: BoxDecoration(
                        color: isPlay ? Colors.green : Colors.red,
                        shape: BoxShape.circle)),
                IconButton(
                    onPressed: () => {
                          setState(() {
                            isPlay = !isPlay;
                            if (!isPlay) {
                              _startTimer();
                              _playController.stop();
                              _textController.repeat(reverse: true);
                            } else {
                              _timer?.cancel();
                              _seconds = 0;
                              _playController.repeat(reverse: true);
                              _textController.stop();
                            }
                          })
                        },
                    icon: Icon(isPlay ? Icons.play_arrow : Icons.pause,
                        size: size.width * 0.25))
              ])),
    ]));
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        _seconds += 1;
      });
    });
  }

  Widget _timerText(BuildContext context) {
    int hour = (_seconds / 3600).floor();
    int minutes = (_seconds / 60).floor();
    int seconds = _seconds % 60;

    String timerText =
        '${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Container(
        height: 30,
        child: Center(
            child: Text(
                _timer != null && _timer!.isActive && !isPlay
                    ? timerText
                    : '00:00:00',
                style: TextStyle(fontSize: 20))));
  }

  @override
  void dispose() {
    _playController.dispose();
    _textController.dispose();
    super.dispose();
  }
}
