import 'dart:convert';
import 'package:hive/hive.dart';
part 'quotes_text_model.g.dart';

@HiveType(typeId: 4)
class QuotesTextModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String textQuotes;
  @HiveField(2)
  final String? authorQuotes;

  QuotesTextModel({
    required this.id,
    required this.textQuotes,
    required this.authorQuotes
  });

  factory QuotesTextModel.fromJson(Map<String, dynamic> json){
    return QuotesTextModel(
        id: json['id'] as int,
        textQuotes: json["quoteText"] as String,
        authorQuotes: json["quoteAuthor"] as String?
    );
  }
  Map<String, dynamic> toJson() => {'id': id, 'quoteText': textQuotes, 'quoteAuthor': authorQuotes};
}