import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Employes{
  final String name;
  final String id;
  final String pass;
  final List tableAssign;

  const Employes({@required this.name, @required this.id, @required this.pass, @required this.tableAssign});
  factory Employes.fromJson(Map<String , dynamic> json) =>
      Employes(
          name: json['name'],
          id: json['id'],
          pass: json['pass'],
          tableAssign: json['tableAssign']
      );
  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'id' : id,
        'pass': pass,
        'tableAssign' : tableAssign
      };
}
class EmployeSnapshot{
  Employes employes;
  DocumentReference ref;

  EmployeSnapshot({this.employes, this.ref});

  EmployeSnapshot.fromSnapshot(DocumentSnapshot snapshot):
        employes = Employes.fromJson(snapshot.data()),
        ref = snapshot.reference;
}