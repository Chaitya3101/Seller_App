import 'package:flutter/material.dart';
import '../auth/signup_screen.dart';

class SellerDashboard extends StatefulWidget {
  @override
  _SellerDashboardState createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard> {
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> titles = [
    "User Registration and Profiles",
    "Product Listing",
    "Inventory Management",
    "Order Management",
    "Payment Processing",
    "Analytics Dashboard",
    "Customer Support",
  ];

  final List<String> descriptions = [
    "Allow sellers to create accounts, manage their profiles, and log transactions.",
    "Enable sellers to add products including descriptions, prices, and images.",
    "Provide tools for sellers to manage stock levels and product variations (e.g. frame types).",
    "Track and manage orders efficiently through all fulfillment stages.",
    "Integrate secure payment gateways (e.g., PayPal, credit cards).",
    "Offer insights into sales performance, traffic, and inventory levels.",
    "Resolve buyer/seller issues and answer inquiries."
  ];

  final List<IconData> icons = [
    Icons.person,
    Icons.add_box,
    Icons.inventory,
    Icons.local_shipping,
    Icons.payment,
    Icons.bar_chart,
    Icons.support_agent,
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isWide = constraints.maxWidth >= 700;

      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Eyewear Seller"),
          backgroundColor: Colors.indigo,
          actions: isWide
              ? [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.account_circle, size: 28),
            )
          ]
              : null,
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
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(icons[index]),
                title: Text(titles[index].split(" ")[0]),
                selected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  Navigator.pop(context); // close drawer
                },
              );
            },
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
                    label: Text(titles[index].split(" ")[0]),
                  ),
                ),
              ),
            if (isWide) VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: selectedIndex == 0
                        ? SellerSignupScreen()
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titles[selectedIndex],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          descriptions[selectedIndex],
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}