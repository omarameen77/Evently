import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/utils/events.dart';

class FirebaseUtils {
  static CollectionReference<Events> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Events.collectionName)
        .withConverter<Events>(
            fromFirestore: (snapshot, _) =>
                Events.fromFireStore(snapshot.data()!),
            toFirestore: (event, _) => event.toFireStore());
  }

  static Future<void> addEventToFireStore(Events event) {
    CollectionReference collectionRef = getEventsCollection();
    DocumentReference docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
