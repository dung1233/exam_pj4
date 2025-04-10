import 'package:exam/API/api.dart';
import 'package:exam/model/place.dart';
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
                child: FutureBuilder<List<Place>>(
                  future: fetchPlaces(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final destinations = snapshot.data!;
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                        children: destinations
                            .map((place) => _buildDestinationCard(place))
                            .toList(),
                      );
                    }
                  },
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

  Widget _buildDestinationCard(Place place) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(place.image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(place.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow, size: 16),
                  Text('${place.rating}',
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
