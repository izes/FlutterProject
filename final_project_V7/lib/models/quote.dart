import 'package:final_project/databaseHelper.dart';

class Quote {
  int quoteId;
  String quoteName;
  int quoteLike;

  Quote(this.quoteId, this.quoteName, this.quoteLike);

  Quote.fromMap(Map<String, dynamic> map) {
    quoteId = map['quoteId'];
    quoteName = map['quoteName'];
    quoteLike = map['quoteLike'];
  }

  Map<String, dynamic> toMap() {
    return {
      DataBaseHelper.colQuoteId: this.quoteId,
      DataBaseHelper.colQuoteName: this.quoteName,
      DataBaseHelper.colQuoteLike: this.quoteLike,
    };
  }
}
