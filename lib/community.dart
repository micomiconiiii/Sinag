import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int _selectedIndex = 1; // Default to "Browse" tab

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
        title: Text('100 C'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('lib/assets/SNIAG 1.png'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Icon(Icons.notifications),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(child: _buildRowCards()), // Keep this centered if you like
            SizedBox(height: 20),
            Padding(padding: EdgeInsets.all(16), child: _buildPost()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Communities",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            _buildCommunity(),

            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Exchange Your Coins",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            fullWidthBox(context),
            SizedBox(height: 20),
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

  Widget _buildRowCards() {
    TextEditingController _postController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture
          CircleAvatar(
            radius: 25,
            backgroundColor: Color(0XFFFBB009),
            backgroundImage: AssetImage('lib/assets/micoid.png'),
          ),
          SizedBox(width: 12),

          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: 50,
                width: 400,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0XFFFCFCFC),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          hintText: "Start connecting with people...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.image_rounded, color: Color(0XFFFBB009)),
                      onPressed: () {
                        String post = _postController.text.trim();
                        if (post.isNotEmpty) {
                          print("User posted: $post");
                          _postController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPost() {
  return Material(
    elevation: 8.0,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0XFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0XFFFBB009),
                backgroundImage: AssetImage('lib/assets/micoid.png'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe", // 👤 Account name
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "1 hour ago",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5), // Spacing between profile info and text
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec in nulla auctor, ornare mi sit amet, varius augue. Suspendisse pellentesque nisl et hendrerit vulputate. Curabitur semper nec diam eu congue. Duis nulla augue, semper rutrum nibh eget, pretium mattis odio. Mauris eu enim malesuada, euismod justo quis, rutrum quam. 👌",
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.star, color: Color(0XFFFBB009)),
              Text('1.2k', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 5),
              Icon(Icons.share, color: Color(0XFF929292)),
              Text('567', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 5),
              Icon(Icons.comment, color: Color(0XFF929292)),
              Text('890', style: TextStyle(color: Colors.grey)),
            ],
          ),
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: 'Interact with them...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
              filled: true,
              fillColor: const Color.fromARGB(255, 230, 227, 227),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCommunity() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0XFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Energy Efficiency',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('ISCS', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10), // Add space between text and button
                  ElevatedButton(
                    onPressed: () {
                      // Add your button action here
                      print("Button Pressed");
                    },
                    child: Text("Join"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0XFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Renewable Energy',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('ICLEI-SEAS', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10), // Add space between text and button
                  ElevatedButton(
                    onPressed: () {
                      // Add your button action here
                      print("Button Pressed");
                    },
                    child: Text("Requested"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              color: Color(0XFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rural Electrification',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Meralco', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10), // Add space between text and button
                  ElevatedButton(
                    onPressed: () {
                      // Add your button action here
                      print("Button Pressed");
                    },
                    child: Text("Volunteer"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget fullWidthBox(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Optional padding
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 120, // You can change the height as needed
      decoration: BoxDecoration(
        color: Color(0XFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'lib/assets/Rectangle 82.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Energy-Saving LED Lamp',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Get the EcoBright LED Lamp with 80% less energy usage.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
