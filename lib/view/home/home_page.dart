import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leadingWidth: 200,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/settings');
            },
            icon: const Icon(Icons.notifications_none_rounded),
          )
        ],
        leading: const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            '럭키비키',
            style: TextStyle(fontFamily: 'EF_Diary', fontSize: 30),
          ),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(width: 300, height: 300, child: CalendarWidget())
          ],
        )),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 예제 데이터를 사용하여 특정 날짜에 이벤트가 있는지 표시
    final Map<int, bool> events = {
      5: true,
      6: true,
      8: true,
    };

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(
            '2023년 6월',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: 30,
            itemBuilder: (context, index) {
              int day = index + 1;
              bool isSelected = day == 5;
              bool hasEvent = events.containsKey(day) && events[day]!;

              return GestureDetector(
                onTap: () {
                  print(day);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      if (hasEvent)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
