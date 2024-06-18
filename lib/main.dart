import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'models/quote.dart';
import 'providers/quote_provider.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuoteProvider(),
      child: MaterialApp(
        title: 'Daily Quotes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: QuoteScreen(),
      ),
    );
  }
}

class QuoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quote'),
      ),
      body: Center(
        child: quoteProvider.dailyQuote.text.isNotEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '"${quoteProvider.dailyQuote.text}"',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              '- ${quoteProvider.dailyQuote.author}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
