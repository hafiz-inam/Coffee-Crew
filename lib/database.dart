import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffeecrew/brew.dart';
import 'package:coffeecrew/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  updateUserData(String name, String sugar, int strength)async{

    return await brewCollection.document(uid).setData({
      'name' : name,
      'sugar' : sugar,
      'strength' : strength,
    }
    );

  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){

    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        sugar: doc.data['sugar'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();

  }

  UserData _userDataFormSnapshot( DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugar: snapshot.data['sugar'],
      strength: snapshot.data['strength'],
    );
  }


  Stream<List<Brew>> get brew{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDataFormSnapshot);
  }

}