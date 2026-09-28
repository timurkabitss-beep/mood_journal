import 'package:flutter/material.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/models/quotes_text_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuotesState extends ChangeNotifier{
  List<QuotesTextModel> _quotesList =  [];
  bool _isLoaded = false;


  List<QuotesTextModel> get quotesList => _quotesList;
  bool get isLoaded => _isLoaded;

  Future<void> loadQuotes()async {
    await

    _isLoaded = true;
    notifyListeners();
  }
}