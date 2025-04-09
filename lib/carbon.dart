import 'package:flutter/material.dart';

void main() {
  runApp(Carbon());
}

class Carbon extends StatelessWidget {
  const Carbon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Outfit'),
      home: CarbonFootprintPage(),
    );
  }
}

class CarbonFootprintPage extends StatelessWidget {
  const CarbonFootprintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Color(0XFFFBB009),
        title: Text('Carbon Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildFootprintBox(0.3),
            SizedBox(height: 15),
            _buildFootprintBox(0.6),
            SizedBox(height: 15),
            _buildFootprintBox(0.9),
          ],
        ),
      ),
    );
  }

  Widget _buildFootprintBox(double progress) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Carbon footprint goal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: Color(0XFFFBB009),
              minHeight: 10,
              borderRadius: BorderRadius.circular(8),
            ),
            SizedBox(height: 8),
            Text(
              '${(progress * 100).toStringAsFixed(0)}% completed',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
