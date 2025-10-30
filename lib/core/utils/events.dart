class Events {
  //! Collection Name
  static const collectionName = "Events";
  //! attributes
  String? id;
  String? eventName;
  String? eventImage;
  String? eventTitle;
  String? eventDesc;
  DateTime? eventDateTime;
  String? eventTime;
  bool? isFavorite;

  //! constructor
  Events({
    this.id = "",
    required this.eventName,
    required this.eventImage,
    required this.eventTitle,
    required this.eventDesc,
    required this.eventDateTime,
    required this.eventTime,
    this.isFavorite = false,
  });
  //! named Constructor
  Events.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data["id"],
            eventName: data["event_Name"],
            eventImage: data["event_Image"],
            eventTitle: data["event_Title"],
            eventDesc: data["event_Desc"],
            eventDateTime:DateTime.fromMillisecondsSinceEpoch(data["event_DateTime"]) ,
            eventTime: data["event_Time"],
            isFavorite: data["is_Favorite"]
            );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "event_Name": eventName,
      "event_Image": eventImage,
      "event_Title": eventTitle,
      "event_Desc": eventDesc,
      "event_DateTime": eventDateTime!.millisecondsSinceEpoch,
      "event_Time": eventTime,
      "is_Favorite": isFavorite,
    };
  }
}
