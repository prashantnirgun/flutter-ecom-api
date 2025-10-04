import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/core/utils/dialogs.dart';
import 'package:flutter_ecom_api/core/utils/formatters.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_bloc.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_state.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_event.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter_ecom_api/features/home/presentation/dashboard.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_bloc.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_event.dart';
import 'package:flutter_ecom_api/features/order/presentation/bloc/order_state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int quantity = 1;
  bool isLoading = false;
  final couponController = TextEditingController();
  final List<Map<String, dynamic>> couponList = [
    {
      "code": "ecomm10",
      "value": 10, // 10% off
      "flag": 1, // 1 = Percent
      "minPrice": 15000,
    },
    {
      "code": "flat500",
      "value": 500, // Flat ₹500 off
      "flag": 2, // 2 = Flat
      "minPrice": 20000,
    },
  ];

  String? appliedCouponCode;
  double discountAmount = 0.0;
  String couponMessage = '';

  void applyCoupon(String code, double totalAmount) {
    final coupon = couponList.firstWhere(
      (c) => c['code'].toString().toLowerCase() == code.toLowerCase(),
      orElse: () => {},
    );

    if (coupon.isEmpty) {
      setState(() {
        couponMessage = 'Invalid coupon code';
        discountAmount = 0.0;
        appliedCouponCode = null;
      });
      return;
    }

    if (totalAmount < coupon['minPrice']) {
      setState(() {
        couponMessage = 'Minimum order ₹${coupon['minPrice']} required';
        discountAmount = 0.0;
        appliedCouponCode = null;
      });

      return;
    }

    double discount = 0.0;
    if (coupon['flag'] == 1) {
      // Percentage
      discount = totalAmount * (coupon['value'] / 100);
    } else {
      // Flat
      discount = coupon['value'].toDouble();
    }

    setState(() {
      appliedCouponCode = coupon['code'];
      discountAmount = discount;
      couponMessage = 'Coupon applied: ₹${discount.toStringAsFixed(2)} off!';
    });
  }

  @override
  void initState() {
    super.initState();
    // Case 1: If user is already loaded from SharedPreferences
    final userState = context.read<UserBloc>().state;
    if (userState is LoginSuccessState) {
      context.read<CartBloc>().add(FetchCartEvent());
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
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state is CartLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.orange),
                      );
                    }

                    if (state is CartFailureState) {
                      return Center(
                        child: Text(
                          state.errorMsg,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }

                    if (state is CartSuccessState) {
                      return state.mCartItems != null &&
                              state.mCartItems!.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.mCartItems!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
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
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Image.network(
                                            state.mCartItems![index].image,
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        //Product INTO
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.mCartItems![index].name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Women Fashion',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                Formatters.currency(
                                                  double.parse(
                                                    state
                                                        .mCartItems![index]
                                                        .price,
                                                  ),
                                                ),
                                                //state.mCartItems![index].price,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        //Quantity + Delete
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                context.read<CartBloc>().add(
                                                  DeleteFromCartEvent(
                                                    cartId: state
                                                        .mCartItems![index]
                                                        .id,
                                                  ),
                                                );
                                              },
                                              padding: EdgeInsets.zero,
                                              icon: Icon(
                                                Icons.delete_outlined,
                                                color: Colors.red,
                                                size: 35,
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      final userId = context
                                                          .read<UserBloc>()
                                                          .state
                                                          .currentUserId;
                                                      if (state
                                                                  .mCartItems![index]
                                                                  .quantity >
                                                              1 &&
                                                          userId != null) {
                                                        context
                                                            .read<CartBloc>()
                                                            .add(
                                                              UpdateQtyEvent(
                                                                userId: userId,
                                                                productId: state
                                                                    .mCartItems![index]
                                                                    .productId,
                                                                qty: 1,
                                                              ),
                                                            );
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    state
                                                        .mCartItems![index]
                                                        .quantity
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      final userId = context
                                                          .read<UserBloc>()
                                                          .state
                                                          .currentUserId;
                                                      if (userId != null) {
                                                        context
                                                            .read<CartBloc>()
                                                            .add(
                                                              UpdateQtyEvent(
                                                                userId: userId,
                                                                productId: state
                                                                    .mCartItems![index]
                                                                    .productId,
                                                                qty: -1,
                                                              ),
                                                            );
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                'No cart items',
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
                    //return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartFailureState) {
            return Center(
              child: Text(
                'No Items in cart',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }
          if (state is CartSuccessState) {
            final totalAmount = state.totalAmount;
            return Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              height: 335,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, -2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 320,
                        child: TextField(
                          controller: couponController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: TextButton(
                                onPressed: () {
                                  applyCoupon(
                                    couponController.text.trim(),
                                    totalAmount,
                                  );
                                },
                                child: Text(
                                  'Apply',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            hintText: 'Enter Discount Code',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        Formatters.currency(totalAmount),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        Formatters.currency(totalAmount - discountAmount),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  BlocConsumer<OrderBloc, OrderState>(
                    listener: (_, state) {
                      if (state is OrderLoadingState) {
                        isLoading = true;
                      }

                      if (state is OrderFailureState) {
                        isLoading = false;
                        AppDialogs.showError(
                          context,
                          title: 'Ordered Failed',
                          desc: state.errorMessage,
                        );
                      }

                      if (state is OrderSuccessState) {
                        isLoading = false;
                        AppDialogs.showSuccess(
                          context,
                          title: 'Order placed successfully',
                          desc: 'Redirecting to Dashboard...',
                        );

                        //Navigator.pop(context);
                        // Inside CartPage when you want to go to ProductPage
                        final dashboardState = context
                            .findAncestorStateOfType<DashboardState>();
                        dashboardState?.navigateToTab(0); // 0 = ProductPage
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            final userId = context
                                .read<UserBloc>()
                                .state
                                .currentUserId;
                            if (userId != null) {
                              context.read<OrderBloc>().add(
                                CreateOrderEvent(
                                  userId: userId,
                                  productId: 1,
                                  status: 1,
                                ),
                              );
                            }
                          },
                          child: isLoading
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(" Processing"),
                                  ],
                                )
                              : Text(
                                  "Checkout",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
