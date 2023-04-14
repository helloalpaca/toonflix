import 'package:flutter/material.dart';

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
        //cardColor: const Color(0xFFF4EDDB),
        cardColor: const Color(0xFFEEFFEE),
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
  final List<int> timeList = [15, 20, 25, 30, 35];
  int pomodorTime = 25;

  void onSetPomodor(int time) {
    setState(() {
      pomodorTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double sWidth = MediaQuery.of(context).size.width;
    const Color rColor = Colors.red;
    final ScrollController scrollController =
        ScrollController(initialScrollOffset: sWidth / 2);

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
              color: Colors.white,
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
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                    horizontal: sWidth * 2 / 5,
                  ),
                  itemCount: timeList.length,
                  itemBuilder: (BuildContext ctx, int idx) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: ButtonFormat(
                        idx: idx,
                        time: timeList[idx],
                        pomodorTime: pomodorTime,
                        onSetPomodor: onSetPomodor,
                        scrollController: scrollController,
                      ),
                    );
                  }),
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
    required this.idx,
    required this.time,
    required this.onSetPomodor,
    required this.pomodorTime,
    required this.scrollController,
  }) : super(key: key);

  final int idx;
  final int time;
  final Function onSetPomodor;
  final int pomodorTime;
  final ScrollController scrollController;

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
      onPressed: () {
        onSetPomodor(time);
        scrollController.jumpTo((scrollController.position.maxScrollExtent -
                scrollController.position.minScrollExtent) /
            5 *
            idx);
      },
      child: Text(
        time.toString(),
        style: TextStyle(
            fontSize: 32,
            color: (pomodorTime == time) ? Colors.red : Colors.white,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
