import 'package:flutter/material.dart';
import 'package:flutter_ecom_api/core/routes/app_routes.dart';
import 'package:flutter_ecom_api/features/home/presentation/home_page.dart';
import 'package:flutter_ecom_api/features/order/presentation/pages/order_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedIndex = 0;
  List<Widget> navWidget = [HomePage(), OrderPage(), HomePage(), HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navWidget[selectedIndex],
      backgroundColor: Colors.black,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.home),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        elevation: 21,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                  Navigator.pushNamed(context, AppRoutes.PRODUCTPAGE);
                });
              },
              icon: Icon(
                selectedIndex == 0
                    ? Icons.dashboard_customize
                    : Icons.dashboard_customize_outlined,
                color: selectedIndex == 0 ? Colors.orange : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                  Navigator.pushNamed(context, AppRoutes.ORDERPAGE);
                });
              },
              icon: Icon(
                selectedIndex == 1 ? Icons.list_alt : Icons.list_alt_outlined,
                color: selectedIndex == 1 ? Colors.orange : Colors.grey,
              ),
            ),
            SizedBox(width: 50),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.CARTPAGE);
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: selectedIndex == 3 ? Colors.orange : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                // selectedIndex = 4;
                // setState(() {});
                Navigator.pushNamed(context, AppRoutes.SETTINGPAGE);
              },
              icon: Icon(
                Icons.account_circle_outlined,
                color: selectedIndex == 4 ? Colors.orange : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
