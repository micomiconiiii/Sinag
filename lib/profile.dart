import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 3; // Default to "Browse" tab
    void _onItemTapped(int index) {
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

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color(0xFFFBB009),
          ),

          // Rounded white panel
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: const ProfileOptionsBox(), // ✅ Include the box here
            ),
          ),

          // Profile Picture Placeholder
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 10),
                ),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundColor: Color.fromARGB(255, 114, 78, 78),
                  child: Icon(Icons.person, size: 60, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
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

class ProfileOptionsBox extends StatelessWidget {
  const ProfileOptionsBox({super.key});

  // For the content of the profile options
  Widget _buildOption(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange[800]),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Rounded box with options and logout button
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildOption(Icons.person, "Account Information"),
            _buildOption(Icons.question_answer, "FAQs"),
            _buildOption(Icons.help_outline, "Help Center"),
            _buildOption(Icons.phone, "Contact Us"),
            _buildOption(Icons.share, "Share App"),
            _buildOption(Icons.star_border, "Rate App"),
            const SizedBox(height: 16),

            // Logout Button, positioned below the options
            ElevatedButton.icon(
              onPressed: () {
                print("User logged out");
                Navigator.pop(context); // Or navigate to login screen
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
