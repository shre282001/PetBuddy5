import 'package:flutter/material.dart';

class MyHistoryPage extends StatefulWidget {
  @override
  _MyHistoryPageState createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Owner'),
            Tab(text: 'Adopter'),

          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Content of Tab 1
          Center(
            child: Text('Owner'),
          ),
          // Content of Tab 2
          Center(
            child: Text('Adopter'),
          ),


        ],
      ),
    );
  }
}