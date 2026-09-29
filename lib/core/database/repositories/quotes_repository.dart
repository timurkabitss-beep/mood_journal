import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/models/quotes_text_model.dart';
import '../hive_box.dart';

class QuotesRepository {
  QuotesRepository._();
  static final QuotesRepository instance = QuotesRepository._();

  Box<QuotesTextModel> get _box => Hive.box<QuotesTextModel>(HiveBoxes.quotesEntry);

  Future<void> initLocalQuotes() async{
    if (_box.isEmpty){
      try{
        final jsonData = await rootBundle.loadString("assets/data/quotes_500_with_ids.json");
        final decodedData = jsonDecode(jsonData);
        List<QuotesTextModel> forModels = [];

        for(var item in decodedData){
          forModels.add(QuotesTextModel.fromJson(item));
        }
        await _box.addAll(forModels);

      }
      catch (e){
       print("Error saving the JSON file $e");
      }

    }
  }

  List<QuotesTextModel> getAllQuotes(){
    return _box.values.toList();
  }


}