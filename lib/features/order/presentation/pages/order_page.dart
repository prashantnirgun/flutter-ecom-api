import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/core/utils/formatters.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_bloc.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_state.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_bloc.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_event.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Case 1: If user is already loaded from SharedPreferences
    final userState = context.read<UserBloc>().state;
    if (userState is LoginSuccessState) {
      final userId = int.parse(userState.user.id);
      context.read<OrderBloc>().add(FetchOrderEvent(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    final userId = state.user.id;

                    context.read<OrderBloc>().add(
                      FetchOrderEvent(userId: int.parse(userId)),
                    );
                  }
                },
                child: BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      );
                    }

                    if (state is OrderFailureState) {
                      return Center(
                        child: Text(
                          state.errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is OrderSuccessState) {
                      return state.mOrders != null && state.mOrders!.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.mOrders!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 10,
                                          spreadRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.shopping_cart_checkout,
                                        size: 45,
                                        color: Colors.orange,
                                      ),
                                      title: Text(
                                        "Bill No : ${state.mOrders![index].orderNumber}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date : ${Formatters.date(state.mOrders![index].createdAt)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Amount : ${Formatters.currency(double.parse(state.mOrders![index].totalAmount))}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'No orders',
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                    } else {
                      return Center(
                        child: Text(
                          "Please login first to view your orders.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
