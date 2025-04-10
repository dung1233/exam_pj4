import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> destinations = [
    {
      'name': 'Hoi An',
      'image': 'assets/img/R.jpg',
      'rating': 4.0,
    },
    {
      'name': 'Sai Gon',
      'image': 'assets/img/S.jpg',
      'rating': 4.5,
    },
    {
      'name': 'Sai Gon',
      'image': 'assets/img/S.jpg',
      'rating': 4.5,
    },
    {
      'name': 'Hoi An',
      'image': 'assets/img/R.jpg',
      'rating': 4.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue, // Màu icon/text khi được chọn
        unselectedItemColor: Colors.grey, // Màu icon/text chưa chọn
        backgroundColor: Colors.white, // Nền thanh bottom
        type:
            BottomNavigationBarType.fixed, // Đảm bảo không tràn khi có 4 items
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 550,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 99, 141, 231),
                      borderRadius: BorderRadius.only(
                        bottomLeft:
                            Radius.circular(40), // 👈 Chỉ bo góc trái dưới
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0, left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi Guy!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 36),
                          Text(
                            "Where are you going next?",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 👇 TextField nổi lên nằm trong Stack nha
                  Positioned(
                    top: 170,
                    left: 50,
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search your destination',
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(20), // 👈 Bo tròn góc
                            borderSide: BorderSide.none, // 👈 Không có viền
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                20), // 👈 Bo tròn khi focus
                            borderSide: BorderSide.none, // 👈 Không có viền
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 56),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab(Icons.hotel, 'Hotels', Colors.orange.shade100),
                  _buildTab(Icons.flight, 'Flights', Colors.pink.shade100),
                  _buildTab(Icons.all_inclusive, 'All', Colors.green.shade100),
                ],
              ),
              SizedBox(height: 20),
              Text('Popular Destinations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                  children: destinations
                      .map((dest) => _buildDestinationCard(dest))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> dest) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(dest['image']), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dest['name'],
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text('${dest['rating']}',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Icon(Icons.favorite, color: Colors.red),
        ),
      ],
    );
  }
}
