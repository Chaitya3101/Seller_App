import 'package:flutter/material.dart';
import 'package:visionmart_seller/screens/order%20management/order_management.dart';

import '../auth/login_screen.dart';
import '../inventory/inventory_screen.dart';
import '../products/add_product_screen.dart';
import '../profiles/seller_profile_page.dart';

class SellerDashboardWithSidebar extends StatefulWidget {
  @override
  _SellerDashboardWithSidebarState createState() =>
      _SellerDashboardWithSidebarState();
}

class _SellerDashboardWithSidebarState
    extends State<SellerDashboardWithSidebar> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> titles = [
    "Dashboard",
    "Product Listing",
    "Inventory",
    "Order Management",
    "Payments",
    "Support"
  ];

  final List<IconData> icons = [
    Icons.dashboard,
    Icons.add_box,
    Icons.inventory,
    Icons.local_shipping,
    Icons.payment,
    Icons.support_agent,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 700;
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Eyewear Seller"),
            backgroundColor: Colors.indigo,
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SellerProfilePage()),
                  );
                },
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SellerLoginScreen()),
                  );
                },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ],
            leading: !isWide
                ? IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState!.openDrawer(),
                  )
                : null,
          ),
          drawer: isWide
              ? null
              : Drawer(
                  child: ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: Icon(icons[index]),
                      title: Text(titles[index]),
                      selected: selectedIndex == index,
                      onTap: () {
                        setState(() => selectedIndex = index);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
          body: Row(
            children: [
              if (isWide)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.all,
                  destinations: List.generate(
                    titles.length,
                    (index) => NavigationRailDestination(
                      icon: Icon(icons[index]),
                      label: Text(titles[index]),
                    ),
                  ),
                ),
              if (isWide) VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildPage(selectedIndex),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(int index) {
    if (index == 0) {
      return _buildDashboard();
    } else if (index == 1) {
      return AddProductScreen(); // ✅ now this is active
    } else if (index == 2) {
      return InventoryScreen(); // ✅ working as well
    } else if (index == 3) {
      return OrderManagementScreen();
    } else {
      return Center(child: Text("This section will be implemented soon."));
    }
  }

  Widget _buildDashboard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dashboard",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        SizedBox(height: 24),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              dashboardCard("Total Products", "120", Icons.inventory),
              dashboardCard("Active Orders", "32", Icons.local_shipping),
              dashboardCard("Delivered Orders", "210", Icons.check_circle),
              dashboardCard("Pending Payments", "5", Icons.warning),
            ],
          ),
        ),
      ],
    );
  }

  Widget dashboardCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, size: 40, color: Colors.indigo),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(value,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo)),
          ],
        ),
      ),
    );
  }
}
