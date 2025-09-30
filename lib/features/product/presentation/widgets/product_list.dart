import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter_ecom_api/features/product/presentation/bloc/product_event.dart';
import 'package:flutter_ecom_api/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_ecom_api/features/product/presentation/pages/detail_page.dart';
import 'package:flutter_ecom_api/features/product/presentation/widgets/product_card.dart';

class ProductList extends StatefulWidget {
  final String categoryId;
  const ProductList({super.key, required this.categoryId});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
    print('caregoryId =====> ${widget.categoryId}');
    context.read<ProductBloc>().add(
      FetchProductEvent(categoryId: widget.categoryId),
    );
  }

  @override
  void didUpdateWidget(covariant ProductList oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(
      'updated caregoryId =====> ${oldWidget.categoryId}  ${widget.categoryId} ${widget.categoryId.runtimeType}',
    );
    if (oldWidget.categoryId != widget.categoryId) {
      context.read<ProductBloc>().add(
        FetchProductEvent(categoryId: widget.categoryId.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          if (state is ProductErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is ProductLoadedState) {
            print('product loaded state is build=====>');
            return state.mProductList.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 11,
                          crossAxisSpacing: 11,
                          childAspectRatio: 8 / 9,
                        ),
                    itemCount: state.mProductList.length,
                    itemBuilder: (BuildContext _, int index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ProductCard(
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  currentProduct: state.mProductList[index],
                                ),
                              ),
                            );
                          },
                          imgPath: state.mProductList[index].image!,
                          name: state.mProductList[index].name!,
                          price: state.mProductList[index].price!,
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'No Products',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
          }
          return Container();
        },
      ),
    );
  }
}
