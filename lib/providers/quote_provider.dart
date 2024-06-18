import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote.dart';

class QuoteProvider with ChangeNotifier {
  List<Quote> _quotes = [
    Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
    Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon"),
    // Add more quotes here
  ];

  Quote _dailyQuote = Quote(text: "", author: "");

  QuoteProvider() {
    _loadDailyQuote();
  }

  Quote get dailyQuote => _dailyQuote;

  void _loadDailyQuote() async {
    final prefs = await SharedPreferences.getInstance();
    final quoteData = prefs.getString('dailyQuote');
    if (quoteData != null) {
      _dailyQuote = Quote.fromJson(jsonDecode(quoteData));
    } else {
      _setRandomQuote();
    }
    notifyListeners();
  }

  void _setRandomQuote() async {
    final random = Random();
    _dailyQuote = _quotes[random.nextInt(_quotes.length)];
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('dailyQuote', jsonEncode(_dailyQuote.toJson()));

    // Schedule the notification
    NotificationService.showDailyQuoteNotification(
      "Today's Quote",
      _dailyQuote.text,
    );

    notifyListeners();
  }

}
