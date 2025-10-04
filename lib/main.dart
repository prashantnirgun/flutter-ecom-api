import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/core/network/api_helper.dart';
import 'package:flutter_ecom_api/core/routes/app_routes.dart';
import 'package:flutter_ecom_api/features/authentication/domain/repositories/user_repo.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_bloc.dart';
import 'package:flutter_ecom_api/features/cart/domain/repositories/cart_repo.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter_ecom_api/features/category/domain/repositories/category_repo.dart';
import 'package:flutter_ecom_api/features/category/presentation/bloc/category_bloc.dart';
import 'package:flutter_ecom_api/features/order/domain/repositories/order_repo.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_bloc.dart';
import 'package:flutter_ecom_api/features/product/domain/repositories/product_repo.dart';
import 'package:flutter_ecom_api/features/product/presentation/bloc/product_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserBloc(userRepository: UserRepository(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(productRepo: ProductRepo(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) =>
              CartBloc(cartRepository: CartRepository(apiHelper: ApiHelper())),
        ),
        BlocProvider(
          create: (context) => OrderBloc(
            orderRepository: OrderRepository(apiHelper: ApiHelper()),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            categoryRepository: CategoryRepository(apiHelper: ApiHelper()),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Smart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.SPLASHPAGE,
      routes: AppRoutes.pageRoutes(),
    );
  }
}
