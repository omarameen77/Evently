import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/utils/events.dart';
import 'package:evently/core/utils/firebase_utils.dart';
import 'package:flutter/material.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Events> favoriteList = [];
  List<Events> eventList = [];
  List<Events> filterEventList = [];

  final List<String> tabNames = [
    "All",
    "Sport",
    "Birthday",
    "Eating",
    "Exhibitor",
    "Gaming",
    "Holiday",
    "Meeting",
    "Workshop",
    "Book Club",
  ];

  void getAllEvents() async {
    QuerySnapshot<Events> querySnapshot =
        await FirebaseUtils.getEventsCollection().get();
    eventList = querySnapshot.docs.map((docs) {
      return docs.data();
    }).toList();
    filterEventList = eventList;
    notifyListeners();
  }

  void getFilterEventFromFireStore() async {
    final selectedTab = tabNames[selectedIndex];
    QuerySnapshot<Events> querySnapshot =
        await FirebaseUtils.getEventsCollection()
            .where("event_Name", isEqualTo: selectedTab)
            .get();

    filterEventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  Future<void> updateIsFavoriteEvent(Events event) async {
    final bool? oldIsFavorite = event.isFavorite;
    event.isFavorite = !(oldIsFavorite ?? false);

    _updateEventInLists(event);

    notifyListeners();

    try {
      await FirebaseUtils.getEventsCollection().doc(event.id).update(
          {"is_Favorite": event.isFavorite}).timeout(Duration(seconds: 1));
    } catch (e) {
      event.isFavorite = oldIsFavorite;
      _updateEventInLists(event);
      notifyListeners();
    }
  }

  void _updateEventInLists(Events event) {
    int eventIndex = eventList.indexWhere((e) => e.id == event.id);
    if (eventIndex != -1) {
      eventList[eventIndex] = event;
    }

    int filterIndex = filterEventList.indexWhere((e) => e.id == event.id);
    if (filterIndex != -1) {
      filterEventList[filterIndex] = event;
    }

    if (event.isFavorite == true) {
      if (!favoriteList.any((e) => e.id == event.id)) {
        favoriteList.add(event);
      }
    } else {
      favoriteList.removeWhere((e) => e.id == event.id);
    }
  }

  void getAllFavoriteEvents() async {
    QuerySnapshot<Events> querySnapshot =
        await FirebaseUtils.getEventsCollection()
            .where("is_Favorite", isEqualTo: true)
            .get();

    favoriteList = querySnapshot.docs.map((doc) => doc.data()).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) {
    selectedIndex = newSelectedIndex;
    if (tabNames[selectedIndex] == "All") {
      getAllEvents();
    } else {
      getFilterEventFromFireStore();
    }
  }
}
