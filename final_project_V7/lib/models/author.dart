import 'package:final_project/databaseHelper.dart';

class Author {
  int authorId;
  String authorName;
  String authorBirth;
  String authorNationality;
  String authorOccupation;
  String authorFact;

  Author(this.authorId, this.authorName, this.authorNationality,
      this.authorOccupation, this.authorFact);

  Author.fromMap(Map<String, dynamic> map) {
    authorId = map['authorId'];
    authorName = map['authorName'];
    authorBirth = map['authorBirth'];
    authorNationality = map['authorNationality'];
    authorOccupation = map['authorOccupation'];
    authorFact = map['authorFact'];
  }

  Map<String, dynamic> toMap() {
    return {
      DataBaseHelper.colAuthorId: this.authorId,
      DataBaseHelper.colAuthorName: this.authorName,
      DataBaseHelper.colAuthorBirth: this.authorBirth,
      DataBaseHelper.colAuthorNationality: this.authorNationality,
      DataBaseHelper.colAuthorOccupation: this.authorOccupation,
      DataBaseHelper.colAuthorFact: this.authorFact,
    };
  }
}
