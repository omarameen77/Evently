import 'package:evently/features/home/taps/home/widget/event_item.dart';
import 'package:evently/provider/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTabScreen extends StatefulWidget {
  const LoveTabScreen({super.key});

  @override
  State<LoveTabScreen> createState() => _LoveTabScreenState();
}

class _LoveTabScreenState extends State<LoveTabScreen> {
  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventListProvider>(context, listen: false).getAllFavoriteEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventListProvider = Provider.of<EventListProvider>(context);
    
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search), 
                    hintText: "Search"
                  ),
                ),
              ),
              Expanded(
                child: eventListProvider.favoriteList.isEmpty
                    ? Center(child: Text("No Favorite Events"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: ListView.builder(
                          itemCount: eventListProvider.favoriteList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return EventItem(
                              events: eventListProvider.favoriteList[index]
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      )
    );
  }
  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}