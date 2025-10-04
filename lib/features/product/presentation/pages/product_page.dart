import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_ecom_api/features/product/presentation/bloc/product_bloc.dart';
// import 'package:flutter_ecom_api/features/product/presentation/bloc/product_state.dart';
// import 'package:flutter_ecom_api/features/product/presentation/pages/detail_page.dart';
// import 'package:flutter_ecom_api/features/product/presentation/widgets/product_card.dart';
import 'package:flutter_ecom_api/features/product/presentation/widgets/product_list.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      // appBar: AppBar(
      //   backgroundColor: Colors.grey.shade200,
      //   centerTitle: true,
      //   leadingWidth: 55,
      //   title: Text(
      //     'Products',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 22,
      //     ),
      //   ),
      //   leading: Padding(
      //     padding: EdgeInsetsGeometry.only(left: 15),
      //     child: GestureDetector(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: CircleAvatar(
      //         radius: 10,
      //         backgroundColor: Colors.white,
      //         child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
      //       ),
      //     ),
      //   ),
      // ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ProductList(categoryId: "0"),
      ),
      /*
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.orange),
                    );
                  }

                  if (state is ProductErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is ProductLoadedState) {
                    return state.mProductList.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.mProductList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      mainAxisSpacing: 11,
                                      crossAxisSpacing: 11,
                                      childAspectRatio: 8 / 9,
                                    ),
                                itemCount: state.mProductList.length,
                                itemBuilder: (BuildContext _, int index) {
                                  return ProductCard(
                                    onPress: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                            currentProduct:
                                                state.mProductList[index],
                                          ),
                                        ),
                                      );
                                    },
                                    imgPath: state.mProductList[index].image!,
                                    name: state.mProductList[index].name!,
                                    price: state.mProductList[index].price!,
                                  );
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No Products',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
      */
    );
  }
}
