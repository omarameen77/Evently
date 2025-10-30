import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/core/utils/events.dart';
import 'package:evently/provider/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  final Events events;
  const EventItem({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              events.eventImage!,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 45,
                height: 55,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat("dd").format(events.eventDateTime!),
                        style: TextStylesHelper.font20PurpleBold,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        DateFormat("MMM").format(events.eventDateTime!),
                        style: TextStylesHelper.font16semiBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.lightBlue,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          events.eventDesc!,
                          style: TextStylesHelper.font16semiBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            eventListProvider.updateIsFavoriteEvent(events);
                          },
                          child: events.isFavorite == true
                              ? Icon(
                                  Icons.favorite,
                                  color: AppColors.purple,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: AppColors.purple,
                                )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
