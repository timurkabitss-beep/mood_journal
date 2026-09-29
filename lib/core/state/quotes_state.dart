import 'package:flutter/material.dart';
import 'package:mood_journal/core/database/repositories/quotes_repository.dart';
import 'package:mood_journal/features/dashboard/view/main_dashboard/view/models/quotes_text_model.dart';


class QuotesState extends ChangeNotifier{
  List<QuotesTextModel> _quotesList =  [];
  bool _isLoaded = false;


  List<QuotesTextModel> get quotesList => _quotesList;
  bool get isLoaded => _isLoaded;

  Future<void> loadQuotes()async {
    _quotesList = QuotesRepository.instance.getAllQuotes();
    _isLoaded = true;
    notifyListeners();
  }
}