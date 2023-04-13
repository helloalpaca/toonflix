import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> timeList = [15, 20, 25, 30, 35];
  int pomodorTime = 15;

  void onSetPomodor(int time) {
    setState(() {
      pomodorTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const Color rColor = Colors.red;
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      backgroundColor: rColor,
      body: Column(
        children: [
          SizedBox(
            height: statusBarHeight,
          ),
          Text(
            pomodorTime.toString(),
            style: const TextStyle(
              color: Colors.green,
              fontSize: 36,
            ),
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
              child: ListView(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                ),
                children: [
                  for (var time in timeList)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: ButtonFormat(
                        time: time,
                        pomodorTime: pomodorTime,
                        onSetPomodor: onSetPomodor,
                      ),
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

class ButtonFormat extends StatelessWidget {
  const ButtonFormat({
    Key? key,
    required this.time,
    required this.onSetPomodor,
    required this.pomodorTime,
  }) : super(key: key);

  final int time;
  final Function onSetPomodor;
  final int pomodorTime;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: (pomodorTime == time) ? Colors.white : Colors.red,
        side: const BorderSide(
          width: 3.0,
          color: Colors.white,
        ),
        elevation: 0,
      ),
      onPressed: () => onSetPomodor(time),
      child: Text(
        time.toString(),
        style: TextStyle(
            fontSize: 32,
            color: (pomodorTime == time) ? Colors.red : Colors.white,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return TextButton(
  //     onPressed: () => onSetPomodor(time),
  //     child: Text(
  //       "HELLO $time",
  //       style: const TextStyle(
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
}
