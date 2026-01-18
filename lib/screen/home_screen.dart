// main.dart
import 'package:flutter/material.dart';
import 'package:mission_attendant_app/screen/permission_staff_screen.dart';
import 'package:mission_attendant_app/screen/search_screen.dart';
import 'package:mission_attendant_app/screen/staff_detail_screen.dart';
import 'package:provider/provider.dart';
import 'dashboard_screen.dart';
import 'logics/theme_logic.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: _buildBottomNavBar(),
      endDrawer: _buildDrawer(),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PermissionStaffScreen()));
        },
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: Icon(Icons.add),
        foregroundColor: Colors.white);
  }

  //Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: const Text("សូមស្វាគមន៍"),
      centerTitle: true,
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage("https://i.pravatar.cc/150"),
        ),
      ),
      actions: [
        // IconButton(
        //   icon: const Icon(Icons.dark_mode, color: Colors.black),
        //   onPressed: () {
        //     // TODO: switch theme logic later
        //   },
        // ),
        Builder(
          builder: (context) => Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationsScreen())
                  );
                },
              ),
              const Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Text(
                    "1",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Build Body
  int _currentIndex = 0;
  Widget _buildBody(){
    return IndexedStack(
      index: _currentIndex,
      children: [
        DashboardScreen(),
        // HomeScreen(),
        SearchScreen(),
        ProfileScreen(),
      ],
    );
  }

  //Build Buttom Navigator
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index){
        if(index == 3){
          _scaffoldKey.currentState!.openEndDrawer();
        }else{
          setState(() {
            _currentIndex = index;
          });
        }
      },
      type: BottomNavigationBarType.fixed,
      // selectedItemColor: Colors.pink,
      // showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "ទំព័រដើម"),
        BottomNavigationBarItem(icon: Icon(Icons.description), label: "ស្វែងរក"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "ប្រវត្តិរូប"),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: "ផ្សេងៗ"),
      ],
    );
  }

  Widget _buildDrawer(){
    int themeIndex = context.watch<ThemeLogic>().themeIndex;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Icon(Icons.face, size: 100)),
          ExpansionTile(
            initiallyExpanded: true,
            title: Text("Change App Theme"),
            children: [
              ListTile(
                leading: Icon(Icons.phone_android),
                title: Text("Change To System"),
                trailing: themeIndex == 0 ? Icon(Icons.check_circle) : SizedBox(),
                onTap: (){
                  context.read<ThemeLogic>().changeToSystem();
                },
              ),
              ListTile(
                leading: Icon(Icons.dark_mode),
                title: Text("Change To Dark"),
                trailing: themeIndex == 1 ? Icon(Icons.check_circle) : SizedBox(),
                onTap: (){
                  context.read<ThemeLogic>().changeToDark();
                },
              ),
              ListTile(
                leading: Icon(Icons.light_mode),
                title: Text("Change To Light"),
                trailing: themeIndex == 2 ? Icon(Icons.check_circle) : SizedBox(),
                onTap: (){
                  context.read<ThemeLogic>().changeToLight();
                },
              ),
            ],
          ),

        ],
      ),
    );
  }

}

