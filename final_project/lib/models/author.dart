import 'package:final_project/databaseHelper.dart';

class Author{
  int authorId;
  String authorName;

  Author(this.authorId, this.authorName);

  Author.fromMap(Map<String,dynamic> map){
    authorId = map['authorId'];
    authorName = map['authorName'];
  }

  Map<String,dynamic> toMap(){
    return{
      DataBaseHelper.colAuthorId: this.authorId,
      DataBaseHelper.colUserName: this.authorName,
    };
  }
}