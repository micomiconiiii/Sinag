import 'package:flutter/material.dart';
import 'package:hackathonui/community.dart';
import 'package:hackathonui/calculator.dart';
import 'package:hackathonui/profile.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/community': (context) => Community(),
        '/calculator': (context) => Calculator(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double percent = 0.0;
  String currentTime = "";
  int _selectedIndex = 0;
  double _thresholdValue = 230.0; // Initial threshold value

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/community');
    }
    if (index == 2) {
      Navigator.pushNamed(context, '/calculator');
    }
    if (index == 3) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  final TextEditingController _thresholdController = TextEditingController();

  @override
  void dispose() {
    _thresholdController.dispose();
    super.dispose();
  }

  Widget _buildIcon(IconData iconData, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Color(0XFFFBB009) : Colors.transparent,
        shape: BoxShape.circle,
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]
                : null,
      ),
      padding: EdgeInsets.all(8),
      child: Icon(iconData, color: isSelected ? Colors.white : Colors.black),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        percent += 0.1;
        if (percent >= 1.0) percent = 0.0;
        currentTime = DateFormat('hh:mm a').format(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text(
          "Sinag",
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0XFFFBB009),
        foregroundColor: Colors.white,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notification_add),
                SizedBox(width: 8),
                Icon(Icons.bar_chart),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              // Main Circle Progress
              _buildCircularProgress(),
              SizedBox(height: 20),
              _buildRowCards(),
              SizedBox(height: 20),
              _buildCarbonGoalCard(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 9,
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, _selectedIndex == 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.public, _selectedIndex == 1),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.calculate_outlined, _selectedIndex == 2),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon(Icons.account_circle, _selectedIndex == 3),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress() {
    return GestureDetector(
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            color: Color(0XFFF3F3F3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 13.0,
              animation: true,
              percent: percent,
              center: Text(
                "${(percent * 100).toStringAsFixed(0)}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Color(0XFFFE9902),
              backgroundColor: Color.fromARGB(255, 213, 213, 213),
              arcBackgroundColor: Color.fromARGB(255, 213, 213, 213),
              arcType: ArcType.FULL,
              startAngle: 215,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildThresholdCard(),
        SizedBox(width: 20),
        _buildPeakHourCard(),
      ],
    );
  }

  Widget _buildThresholdCard() {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 162,
        width: 138,
        decoration: BoxDecoration(
          color: Color(0XFFF3F3F3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Daily Threshold\n',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: '$_thresholdValue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    TextSpan(
                      text: '/1250 W',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _showThresholdDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFFBB009),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Change Max',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeakHourCard() {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 162,
        width: 136,
        decoration: BoxDecoration(
          color: Color(0XFFF3F3F3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Peak hours\n',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextSpan(
                      text: currentTime,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFFBB009),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'View Graph',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarbonGoalCard() {
    return Material(
      elevation: 8.0,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 100,
        width: 300,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Color(0XFFF3F3F3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Carbon Footprint Goal', style: TextStyle(fontSize: 14)),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey[300],
              color: Color(0XFFFBB009),
              minHeight: 9.0,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFFB5E8BD),
                minimumSize: Size(100, 40),
              ),
              child: Text(
                '250kg of CO2',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThresholdDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Daily Limit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Set New Threshold Value'),
              Slider(
                value: _thresholdValue,
                min: 0,
                max: 1250,
                divisions: 25,
                label: _thresholdValue.toStringAsFixed(0),
                onChanged: (double newValue) {
                  setState(() {
                    _thresholdValue = newValue;
                  });
                },
              ),
              Text(
                'Threshold: ${_thresholdValue.toStringAsFixed(0)} W',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                print('New Max: $_thresholdValue');
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
