import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xFFE7626C),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xFF232B55),
          ),
        ),
        cardColor: const Color(0xFFF4EDDB),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pomodorMinute = 25;
  int totalSeconds = 25; //TODO: 60 곱하기 추가 + 초기값에 함수or변수 못들어가는 이유?
  int totalRounds = 0;
  int totalGoals = 0;
  bool isRunning = false;
  bool isRefresh = false;
  int refreshMinute = 5;
  List<int> minuteList = [15, 20, 25, 30, 35];
  late Timer timer;

  int minuteToseconds(int minute) => minute; //TODO: 60 곱하기 추가

  void onTick(Timer timer) {
    if (totalSeconds == 1) {
      setState(() {
        totalRounds = totalRounds + 1;
        if (totalRounds >= 4) {
          totalRounds = 0;
          totalGoals = totalGoals + 1;
          onRefreshTime();
        }
        if (totalGoals >= 12) {
          totalGoals = 0;
        }
        isRunning = false;
        totalSeconds = minuteToseconds(pomodorMinute);
      });
      timer.cancel();
    } else {
      setState((() {
        totalSeconds = totalSeconds - 1;
      }));
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRefreshTime() {
    isRefresh = true;
    totalSeconds = minuteToseconds(refreshMinute);
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTickRefresh,
    );
  }

  void onTickRefresh(Timer timer) {
    if (totalSeconds == 1) {
      setState(() {
        isRefresh = false;
        totalSeconds = pomodorMinute;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds -= 1;
      });
    }
  }

  void onResetPressed() {
    if (isRunning) {
      timer.cancel();
    }
    setState(() {
      isRunning = false;
      totalSeconds = minuteToseconds(pomodorMinute);
    });
  }

  void setPomodorTime(int minute) {
    if (isRunning) {
      onPausePressed();
    }
    setState(() {
      pomodorMinute = minute;
      totalSeconds = minuteToseconds(pomodorMinute);
    });
  }

  String formatHour(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String formatMinute(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5);
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const Color rColor = Colors.red;

    return Scaffold(
      backgroundColor: rColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          const Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Text(
                "POMOTIMER",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Center(
              child: Column(
                children: [
                  Text(
                    isRefresh ? "REFRESH TIME! ALL BUTTON DISABLED" : "",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimeCard(
                        rColor: rColor,
                        content: formatHour(totalSeconds),
                        isRefresh: isRefresh,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        ":",
                        style: TextStyle(
                          fontSize: 89,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TimeCard(
                        rColor: rColor,
                        content: formatMinute(totalSeconds),
                        isRefresh: isRefresh,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          //아래 속성들을 조절하여 원하는 값을 얻을 수 있다.
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white.withOpacity(0.02),
                            Colors.white,
                            Colors.white,
                            Colors.white.withOpacity(0.02)
                          ],
                          stops: const [0, 0.2, 0.8, 1],
                          tileMode: TileMode.clamp,
                        ).createShader(bounds);
                      },
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        itemCount: minuteList.length,
                        itemBuilder: (BuildContext ctx, int idx) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: MinuteButton(
                                mainColor: rColor,
                                isRefresh: isRefresh,
                                pomodorMinute: pomodorMinute,
                                setPomodorTime: setPomodorTime,
                                minute: minuteList[idx],
                              ));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 120,
                        color: Colors.white.withOpacity(0.8),
                        onPressed: isRefresh
                            ? () {}
                            : (isRunning ? onPausePressed : onStartPressed),
                        icon: Icon(isRunning
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill),
                      ),
                      IconButton(
                        iconSize: 50,
                        color: Colors.white.withOpacity(0.8),
                        onPressed: isRefresh ? () {} : onResetPressed,
                        icon: const Icon(Icons.restore),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundCard(
                    totalRounds: totalRounds,
                    maxRounds: 4,
                    text: "Rounds",
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  RoundCard(
                    totalRounds: totalGoals,
                    maxRounds: 12,
                    text: "Goals",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeCard extends StatefulWidget {
  final Color rColor;
  final String content;
  final bool isRefresh;

  const TimeCard({
    super.key,
    required this.rColor,
    required this.content,
    required this.isRefresh,
  });

  @override
  State<TimeCard> createState() => _TimeCardState();
}

class _TimeCardState extends State<TimeCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(10, -10),
          child: Container(
            width: 100,
            height: 160,
            decoration: BoxDecoration(
              color: widget.isRefresh
                  ? Colors.green.withOpacity(0.8)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(5, -5),
          child: Container(
            width: 110,
            height: 160,
            decoration: BoxDecoration(
              color: widget.isRefresh
                  ? Colors.green.withOpacity(0.8)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.isRefresh ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              widget.content,
              style: TextStyle(
                color: widget.isRefresh ? Colors.white : widget.rColor,
                fontSize: 89,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MinuteButton extends StatelessWidget {
  final Color mainColor;
  final int pomodorMinute;
  final bool isRefresh;
  final Function setPomodorTime;
  final int minute;

  const MinuteButton(
      {super.key,
      required this.mainColor,
      required this.pomodorMinute,
      required this.isRefresh,
      required this.setPomodorTime,
      required this.minute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: (pomodorMinute == minute) ? Colors.white : mainColor,
        side: const BorderSide(
          width: 3.0,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      onPressed: isRefresh ? null : () => setPomodorTime(minute),
      child: Text(
        "$minute",
        style: TextStyle(
            fontSize: 32,
            color: isRefresh
                ? Colors.white
                : ((pomodorMinute == minute) ? mainColor : Colors.white),
            fontWeight: FontWeight.w600),
      ),
    );
  }
}

class RoundCard extends StatelessWidget {
  const RoundCard({
    Key? key,
    required this.totalRounds,
    required this.maxRounds,
    required this.text,
  }) : super(key: key);

  final int totalRounds;
  final int maxRounds;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$totalRounds/$maxRounds",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
