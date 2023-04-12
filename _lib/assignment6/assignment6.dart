import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final Color yColor = const Color(0xFFFEF754);
  final Color pColor = const Color(0xFF9C6BCE);
  final Color gColor = const Color(0xFFBCEE4B);
  final Color alertColor = const Color(0xFFBC2482);
  final List<String> days = ["17", "18", "19", "20", "21"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/profile.jpeg"),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "MONDAY 16",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        "TODAY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: alertColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "17",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "18",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "19",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "20",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 38,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DailyScheduleCard(
                  bgColor: yColor,
                  startHour: "11",
                  startMinute: "30",
                  endHour: "12",
                  endMinute: "30",
                  title: "DESIGN\nMEETING",
                  attendant: const ["ALEX", "HELENA", "NANA"],
                ),
                const SizedBox(
                  height: 10,
                ),
                DailyScheduleCard(
                  bgColor: pColor,
                  startHour: "12",
                  startMinute: "35",
                  endHour: "14",
                  endMinute: "10",
                  title: "DAILY\nPROJECT",
                  attendant: const [
                    "ME",
                    "RICHARD",
                    "CIRY",
                    "MEME",
                    "MYMY",
                    "HEHE",
                    "HIHI"
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                DailyScheduleCard(
                  bgColor: gColor,
                  startHour: "15",
                  startMinute: "00",
                  endHour: "16",
                  endMinute: "30",
                  title: "WEEKLY\nPLANNING",
                  attendant: const ["DEN", "NANA", "MARK"],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getDaysListWidget() {
    List<Widget> childs = [];

    childs.add(Row(
      children: [
        const Text(
          "TODAY",
          style: TextStyle(
            color: Colors.white,
            fontSize: 38,
            fontWeight: FontWeight.w400,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Icon(
          Icons.circle,
          size: 10,
          color: alertColor,
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    ));

    for (var element in days) {
      childs.add(Row(
        children: [
          Text(
            element,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 38,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ));
    }

    return childs;
  }
}

class DailyScheduleCard extends StatelessWidget {
  final String startHour, startMinute, endHour, endMinute, title;
  final List<String> attendant;
  final Color bgColor;

  const DailyScheduleCard(
      {super.key,
      required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute,
      required this.title,
      required this.attendant,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  startHour,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 0.8,
                  ),
                ),
                Text(
                  startMinute,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.black,
                  ),
                ),
                Text(
                  endHour,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  endMinute,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.w400,
                      height: 0.8),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: getAttendantsListWidget(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getAttendantsListWidget() {
    List<Widget> childs = [];
    if (attendant.length > 3) {
      for (var i = 0; i < 3; i++) {
        childs.add(Row(
          children: [
            Text(
              attendant[i],
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
      }
      childs.add(
        Text(
          "+${attendant.length - 3}",
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      );
    } else {
      for (var i = 0; i < attendant.length; i++) {
        childs.add(Row(
          children: [
            Text(
              attendant[i],
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ));
      }
    }

    return childs;
  }
}
