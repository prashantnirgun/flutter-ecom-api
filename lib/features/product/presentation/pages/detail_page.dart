import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_event.dart';
import 'package:flutter_ecom_api/features/cart/presentation/bloc/cart_state.dart';
import 'package:flutter_ecom_api/features/product/data/models/product_model.dart';

class DetailPage extends StatefulWidget {
  final ProductModel currentProduct;

  const DetailPage({super.key, required this.currentProduct});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
  int count = 1;
  List<Color> mColors = [
    Colors.black,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.pinkAccent,
  ];

  List<Map<String, dynamic>> mDetails = [
    {
      "title": "Description",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "title": "Specification",
      "description":
          "Lorem1 ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "title": "Reviews",
      "description":
          "Lorem2 ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
  ];
  int isTitleIndex = 0;
  int isColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    final imgPath = widget.currentProduct.image;
    final name = widget.currentProduct.name;
    final price = widget.currentProduct.price;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.share),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.favorite_border_outlined),
                    ),
                  ],
                ),
                Image.network(
                  imgPath!,
                  height: MediaQuery.of(context).size.height * 0.20,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.4,
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xfff5f5f5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  price!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Text(
                //     "Seller:Sai Krupa",
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.grey,
                //     ),
                //   ),
                // ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Icon(Icons.star, size: 15, color: Colors.white),
                            Text("4.8", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "(100+ Reviews)",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text("Color"),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: mColors.length,
                    itemBuilder: (BuildContext _, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isColorIndex = index;
                          });
                        },
                        child: isColorIndex == index
                            ? Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: BoxBorder.all(
                                    color: mColors[index],
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mColors[index],
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mColors[index],
                                ),
                              ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: mDetails.length,
                    itemBuilder: (BuildContext _, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isTitleIndex = index;
                          });
                        },
                        child: Container(
                          width: 110,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: isTitleIndex == index
                                ? Colors.orange
                                : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              mDetails[index]["title"],
                              style: TextStyle(
                                color: isTitleIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  mDetails[isTitleIndex]["description"],
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 70,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (count > 1) {
                                count--;
                              }
                            });
                          },
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Text("$count", style: TextStyle(color: Colors.white)),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  BlocConsumer<CartBloc, CartState>(
                    listener: (_, state) {
                      if (state is CartLoadingState) {
                        isLoading = true;
                      }

                      if (state is CartFailureState) {
                        isLoading = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.errorMsg),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }

                      if (state is CartSuccessState) {
                        isLoading = false;
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Item added to cart Successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(
                            AddToCartEvent(
                              productId: int.parse(
                                widget.currentProduct.id.toString(),
                              ),
                              qty: count,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          minimumSize: Size(160, 60),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
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
                                  Text("Adding"),
                                ],
                              )
                            : Text(
                                "Add to Cart",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
