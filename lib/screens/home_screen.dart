import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quote'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add a default background image
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: quoteProvider.dailyQuote.text.isNotEmpty
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '"${quoteProvider.dailyQuote.text}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '- ${quoteProvider.dailyQuote.author}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
