import 'dart:convert';

import 'package:all_in_one/chat_service.dart';
import 'package:all_in_one/image_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _inputController = TextEditingController();
  String _response = "";
  bool _isLoading = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _inputController.clear();
          _response = "";
        });
      }
    });
    super.initState();
  }


  void handleSubmit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _response = "";
    });

    String userInput = _inputController.text.trim();
    dynamic result;

    if (_tabController.index == 0) {
      result = await ChatService.getChatResponse(userInput);
    } else {
      result = await ImageService.generateImage(userInput);
    }

    setState(() {
      _response = result;
      _isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("AI Assistant", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,             // 👈 Selected tab color (white)
          unselectedLabelColor: Colors.grey,   // 👈 Unselected tab color (gray)
          tabs: const [
            Tab(icon: Icon(Icons.chat_bubble_outline), text: "Chat"),
            Tab(icon: Icon(Icons.image_outlined), text: "Image"),
          ],
        ),
      ),
      drawer: _buildDrawer(),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          buildTabContent("Chat"),
          buildTabContent("Image"),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[800],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
                ),
                SizedBox(height: 12),
                Text(
                  "Welcome User",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, "Home"),
          _buildDrawerItem(Icons.login, "Sign In"),
          _buildDrawerItem(Icons.settings, "Settings"),
          _buildDrawerItem(Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () => Navigator.pop(context), // Close drawer
    );
  }

  Widget buildTabContent(String type) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _inputController,
            decoration: InputDecoration(
              hintText: "Enter your prompt",
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: handleSubmit,
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 20),
          _isLoading
              ? const CircularProgressIndicator()
              : _response == null
              ? const SizedBox.shrink()
              : Expanded(
            child: SingleChildScrollView(
              child: type == "Image" && _response.toString().startsWith("data:image")
                  ? SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.memory(
                  base64Decode(_response.split(',').last),
                  fit: BoxFit.contain,
                ),
              )
                  : Text(
                _response.toString(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),

        ],
      ),
    );
  }

}
