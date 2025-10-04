import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_bloc.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_event.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_state.dart';
import 'package:flutter_ecom_api/features/cart/presentation/pages/cart_page.dart';
import 'package:flutter_ecom_api/features/home/presentation/home_page.dart';
import 'package:flutter_ecom_api/features/home/presentation/setting_page.dart';
import 'package:flutter_ecom_api/features/order/presentation/pages/order_page.dart';
import 'package:flutter_ecom_api/features/product/presentation/pages/product_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int index = 2;
  List<Widget> navWidget = [
    ProductPage(),
    OrderPage(),
    HomePage(),
    CartPage(),
    SettingPage(),
  ];
  List<String> titles = ['Products', 'Orders', 'Home', 'Cart', 'Settings'];

  void navigateToTab(int tabIndex) {
    setState(() {
      index = tabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.format_list_bulleted_add, size: 30),
      Icon(Icons.list_alt, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.add_shopping_cart, size: 30),
      Icon(Icons.settings, size: 30),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          titles[index],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state is LoginSuccessState
                ? IconButton(
                    onPressed: showLogoutDialog,
                    icon: const Icon(Icons.logout),
                  )
                : SizedBox(),
          ),
        ],
        //backgroundColor: Colors.orangeAccent,
      ),
      body: navWidget[index],
      bottomNavigationBar: Theme(
        data: Theme.of(
          context,
        ).copyWith(iconTheme: IconThemeData(color: Colors.black)),
        child: CurvedNavigationBar(
          color: Colors.orangeAccent,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.green,
          height: 60,
          index: index,
          items: items,
          onTap: (index) => setState(() {
            this.index = index;
          }),
        ),
      ),
    );
  }

  void showLogoutDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: 'Logout',
      desc: 'Are you sure you want to logout?',
      btnCancelText: 'Cancel',
      btnCancelOnPress: () {
        // Just dismiss the dialog
      },
      btnOkText: 'Logout',
      btnOkOnPress: () {
        // Perform logout
        context.read<UserBloc>().add(LogoutUserEvent());

        // Navigate to login and remove all previous routes
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
      btnOkIcon: Icons.logout,
      btnCancelIcon: Icons.close,
      onDismissCallback: (type) {
        debugPrint('Logout dialog dismissed: $type');
      },
    ).show();

    /*
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic here
                context.read<UserBloc>().add(LogoutUserEvent());
                //Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );

                // Give a slight delay for the state to update before exiting
                /*
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop(); // closes the app
                  } else if (Platform.isIOS) {
                    exit(
                      0,
                    ); // use cautiously on iOS (Apple discourages forced exit)
                  }
                });
                */
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
    */
  }
}
