import 'package:flutter/material.dart';

void main() => runApp(OrderManagementApp());

class OrderManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderManagementScreen(),
      theme: ThemeData(
        fontFamily: 'Inter', // Optional: For modern look
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderManagementScreen extends StatefulWidget {
  @override
  State<OrderManagementScreen> createState() => _OrderManagementScreenState();
}

class _OrderManagementScreenState extends State<OrderManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> pendingOrders = [
    {
      "orderNo": "1004",
      "ref": "101",
      "name": "John Smith",
      "desc": "1 × Product Name",
      "date": "Mar 7, 2024",
      "status": "Pending"
    },
    {
      "orderNo": "1005",
      "ref": "102",
      "name": "John Smith",
      "desc": "3 × Product 2, 1: Product 3",
      "date": "Mar 7, 2024",
      "status": "Pending"
    },
    {
      "orderNo": "1006",
      "ref": "103",
      "name": "John Smithe",
      "desc": "1 × Product Name",
      "date": "Mar 7, 2024",
      "status": "Pending"
    },
    {
      "orderNo": "1007",
      "ref": "104",
      "name": "John Doe",
      "desc": "1 × Product Name",
      "date": "Mar 7, 2024",
      "status": "Pending"
    },
    {
      "orderNo": "1008",
      "ref": "105",
      "name": "John Smith",
      "desc": "1 × Product Name",
      "date": "Mar 7, 2024",
      "status": "Pending"
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  Widget _buildStatusChip(String status) {
    Color bgColor = Color(0xFFFFF3E0);
    Color txtColor = Color(0xFFB47A0F);
    if (status == "Pending") {
      bgColor = Color(0xFFFFF3E0);
      txtColor = Color(0xFFB47A0F);
    }
    // Add more if-else for different statuses (Shipped, Delivered, Cancelled)
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: txtColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildOrderTile(Map<String, String> order) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
          title: Row(
            children: [
              Text(
                "Order #${order["orderNo"]}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(width: 8),
              Text(
                order["name"]!,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order #${order["ref"]}",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              SizedBox(height: 2),
              Text(
                order["desc"]!,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatusChip(order["status"]!),
                  SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF3F43BF),
                      minimumSize: Size(54, 34),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: TextStyle(fontWeight: FontWeight.bold),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: Text("View"),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                order["date"]!,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Divider(thickness: 1, height: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: 20,
              left: mediaQuery.size.width * 0.02,
              right: mediaQuery.size.width * 0.02,
              bottom: mediaQuery.viewInsets.bottom + 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: mediaQuery.size.height - mediaQuery.padding.top - 28,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 18),
                      child: Text(
                        "Order Management",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 0),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Color(0xFF3F43BF),
                        unselectedLabelColor: Colors.black54,
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                        unselectedLabelStyle:
                            TextStyle(fontWeight: FontWeight.w500),
                        indicatorColor: Color(0xFF3F43BF),
                        indicatorWeight: 3,
                        tabs: [
                          Tab(text: "Pending"),
                          Tab(text: "Shipped"),
                          Tab(text: "Delivered"),
                          Tab(text: "Cancelled"),
                        ],
                      ),
                    ),
                    Divider(height: 1, thickness: 1),
                    Flexible(
                      child: SizedBox(
                        height: mediaQuery.size.height * 0.7,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: pendingOrders.length,
                              itemBuilder: (context, index) {
                                return _buildOrderTile(pendingOrders[index]);
                              },
                            ),
                            Center(
                                child: Text("No Shipped Orders",
                                    style: TextStyle(fontSize: 16))),
                            Center(
                                child: Text("No Delivered Orders",
                                    style: TextStyle(fontSize: 16))),
                            Center(
                                child: Text("No Cancelled Orders",
                                    style: TextStyle(fontSize: 16))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
