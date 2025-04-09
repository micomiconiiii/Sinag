import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int _selectedRadio = 0;
  int _selectedIndex = 2; // Default to "Browse" tab
  String selectedOption = 'Month'; // or whatever your default is

  TextEditingController _averageBillController = TextEditingController();
  TextEditingController _hoursPerDayController = TextEditingController();
  TextEditingController _daysPerWeekController = TextEditingController();

  double _calculatedValue = 0.0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/'); // Navigate to Home
    } else if (index == 1) {
      Navigator.pushNamed(context, '/community');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/calculator');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  // Function to calculate the bill and other values based on user inputs
  void _calculateValues() {
    double averageBill = double.tryParse(_averageBillController.text) ?? 0.0;
    double hoursPerDay = double.tryParse(_hoursPerDayController.text) ?? 0.0;
    double daysPerWeek = double.tryParse(_daysPerWeekController.text) ?? 0.0;

    // Example Calculation: multiplying average bill by hours per day and days per week
    setState(() {
      _calculatedValue = averageBill * hoursPerDay * daysPerWeek;
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('lib/assets/SNIAG 1.png', height: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align all to the left
          children: [
            // 1st row: Full-width empty rounded rectangle
            Text(
              "Appliance Electricity Calculator",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            // Orange Box
            SizedBox(height: 10),

            Container(
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ), // Adds spacing on both sides
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Color(0xFFFBB009), Color(0xFFFE9902)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PHP $_calculatedValue",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  DropdownButton<String>(
                    value: selectedOption,
                    dropdownColor: Colors.orange[100],
                    iconEnabledColor: Colors.white,
                    underline: SizedBox(), // Removes underline
                    style: TextStyle(color: Colors.black),
                    items:
                        <String>['Month', 'Annual', 'Daily'].map((
                          String value,
                        ) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange[100], // Background color
                                borderRadius: BorderRadius.circular(
                                  12,
                                ), // Set the border radius
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ), // Optional padding
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: const Color.fromARGB(
                                    255,
                                    36,
                                    36,
                                    36,
                                  ), // Text color
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center horizontally
                children: [
                  // Average Monthly Bill with its input box
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Positioned(
                        top: -12,
                        left: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            "Average Monthly Bill",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 12,
                        right: 12,
                        child: TextField(
                          controller: _averageBillController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (_) => _calculateValues(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Appliance text label and input fields
                  Text(
                    "Appliance",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Appliance row with two containers (text fields)
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the row
                    children: [
                      Container(
                        height: 50,
                        width: 175, // Set width to half of 350
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(29),
                            bottomLeft: Radius.circular(20),
                          ),
                          color: Color(0XFFF3F3F3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 175, // Set width to half of 350
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Colors.orange,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 4th row: Two rounded rectangles beside each other
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Row with Labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hours per day",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Days per week",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Second Row with Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0XFFF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _hoursPerDayController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                        onChanged: (_) => _calculateValues(),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0XFFF3F3F3),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 6,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _daysPerWeekController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: InputBorder.none,
                        ),
                        onChanged: (_) => _calculateValues(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
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
}
