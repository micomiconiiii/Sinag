import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
        title: Text('Carbon Footprint Tracker'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the root (main.dart)
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCircularProgressWithCloud(0.65), // <--- Added here
            SizedBox(height: 30),
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

  Widget _buildCircularProgressWithCloud(double percent) {
    return CircularPercentIndicator(
      radius: 90.0,
      lineWidth: 13.0,
      animation: true,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud, size: 40, color: Colors.grey[700]),
          SizedBox(height: 8),
          Text(
            "${(percent * 100).toStringAsFixed(0)}%",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Color(0XFFFE9902),
      backgroundColor: Color.fromARGB(255, 213, 213, 213),
      arcType: ArcType.FULL,
      arcBackgroundColor: Color.fromARGB(255, 213, 213, 213),
      startAngle: 215,
    );
  }
}
