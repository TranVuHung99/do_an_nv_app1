import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_nv_app/modules/messages.dart';

class FireStoreDatabaseMessage{
  Future<void> upLoadMessage(String message, DateTime date, String id, String name) async{
    return await FirebaseFirestore.instance.collection('messages').add({
        'senderID' : id,
        'sender': name,
        'message': message,
        'createAt': date
    }).then((value) => 'success');
  }
  Stream<List<MessagesSnapshot>> getMessageFromFirebase(){
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('messages')
        .orderBy('createAt', descending: true)
        .snapshots();
    return stream.map((QuerySnapshot querySnapshot) =>
      querySnapshot.docs.map((DocumentSnapshot docs) =>
          MessagesSnapshot.fromSnapshot(docs)
      ).toList()
    );
  }
}
