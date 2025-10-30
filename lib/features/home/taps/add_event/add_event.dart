import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/core/utils/events.dart';
import 'package:evently/core/utils/firebase_utils.dart';
import 'package:evently/features/home/taps/home/widget/custom_tabs_bottom.dart';
import 'package:evently/provider/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  DateTime? selectedDate;
  String formatDate = "";
  TimeOfDay? selectedTime;
  String formatTime = "";

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  final List<String> tabImages = [
    EventImages.sport,
    EventImages.birthday,
    EventImages.eating,
    EventImages.exhibitor,
    EventImages.gaming,
    EventImages.holiday,
    EventImages.meeting,
    EventImages.workshop,
    EventImages.bookClub,
  ];
  late EventListProvider eventListProvider;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Create Event", style: TextStylesHelper.font20PurpleBold),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(16),
                      child: Image.asset(tabImages[eventListProvider.selectedIndex],
                          fit: BoxFit.contain),
                    ),
                    SizedBox(height: height * 0.01),
                    DefaultTabController(
                      initialIndex: 0,
                      length: 9,
                      child: CustomTabsBottom(
                        showAllTab: false,
                        selectedBackgroundColor: AppColors.purple,
                        unselectedBackgroundColor: Colors.transparent,
                        selectedTextColor: AppColors.offWhite,
                        unselectedTextColor: AppColors.purple,
                        unselectedBorder: AppColors.purple,
                        onTap: (index) {
                          eventListProvider.changeSelectedIndex(index);
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text("Title", style: TextStylesHelper.font16semiBold),
                    SizedBox(height: height * 0.01),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: "Event Title",
                        prefixIcon: Icon(Icons.edit_calendar),
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please Enter Title";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    Text("Description", style: TextStylesHelper.font16semiBold),
                    SizedBox(height: height * 0.01),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _descController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Event Description",
                      ),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return "Please Enter Description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: width * 0.04),
                        Text("Event Date",
                            style: TextStylesHelper.font16semiBold),
                        Expanded(child: SizedBox()),
                        TextButton(
                            onPressed: () {
                              showDate();
                            },
                            child: Text(selectedDate == null
                                ? "Choose Date"
                                : formatDate))
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined),
                        SizedBox(width: width * 0.04),
                        Text("Event Time",
                            style: TextStylesHelper.font16semiBold),
                        Expanded(child: SizedBox()),
                        TextButton(
                            onPressed: () {
                              showTime();
                            },
                            child: Text(selectedTime == null
                                ? "Choose Time"
                                : formatTime))
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Text("Location", style: TextStylesHelper.font16semiBold),
                    SizedBox(height: height * 0.01),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.purple)),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.purple),
                            child: Center(
                              child: Icon(
                                Icons.my_location_sharp,
                                color: AppColors.lightBlue,
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Text("Choose Event Location",
                              style: TextStylesHelper.font16PurpleBold),
                          Expanded(child: SizedBox()),
                          Icon(Icons.arrow_right, color: AppColors.purple),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        addEvent();
                      },
                      child: Text(
                        'Add Event',
                        style: TextStylesHelper.font20WhiteMedium,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> showDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {
      selectedDate = chooseDate;
      if (selectedDate != null) {
        formatDate = DateFormat("dd/MM/yyyy").format(selectedDate!);
      }
    });
  }

  Future<void> showTime() async {
    var chooseTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      selectedTime = chooseTime;
      if (selectedTime != null) {
        formatTime = selectedTime!.format(context);
      }
    });
  }

  void addEvent() async {
    if (_key.currentState!.validate()) {
      final event = Events(
        eventName: eventListProvider.tabNames[eventListProvider.selectedIndex],
        eventImage: tabImages[eventListProvider.selectedIndex],
        eventTitle: _titleController.text,
        eventDesc: _descController.text,
        eventDateTime: selectedDate,
        eventTime: formatTime,
      );

      try {
        await FirebaseUtils.addEventToFireStore(event);
        eventListProvider.getAllEvents();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event added successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add event: $e')),
        );
      }
    }
  }
}
