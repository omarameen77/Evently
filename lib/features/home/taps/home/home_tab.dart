import 'package:evently/features/home/taps/home/widget/custom_appbar_home.dart';
import 'package:evently/features/home/taps/home/widget/event_item.dart';
import 'package:evently/provider/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EventListProvider>(context, listen: false).getAllEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: CustomHomeAppBar(),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: [
            Expanded(
              child: eventListProvider.filterEventList.isEmpty
                  ? const Center(child: Text("Event is Empty"))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.builder(
                        itemCount: eventListProvider.filterEventList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return EventItem(
                            events: eventListProvider.filterEventList[index],
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
