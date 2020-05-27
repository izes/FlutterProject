import 'package:final_project/databaseHelper.dart';

class User{
  int id;
  String userName;

  User(this.id, this.userName);

  User.fromMap(Map<String,dynamic> map){
    id = map['id'];
    userName = map['userName'];
  }

  Map<String,dynamic> toMap(){
    return{
      DataBaseHelper.colId: this.id,
      DataBaseHelper.colUserName: this.userName,
    };
  }
}