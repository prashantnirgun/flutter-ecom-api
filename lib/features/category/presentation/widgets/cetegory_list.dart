import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/category/presentation/bloc/category_bloc.dart';
import 'package:flutter_ecom_api/features/category/presentation/bloc/category_event.dart';
import 'package:flutter_ecom_api/features/category/presentation/bloc/category_state.dart';
import 'package:flutter_ecom_api/features/product/presentation/widgets/product_list.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String categoryId = "0";
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCateogryEvent());
  }

  final List<IconData> iconLists = [
    Icons.android,
    Icons.laptop_mac,
    Icons.phonelink,
    Icons.tablet,
    Icons.headphones,
    Icons.desktop_mac,
    Icons.devices,
    Icons.devices,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            }

            if (state is CategoryLoadedState) {
              final categories = state.mCategoryList;
              return SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          categoryId = category.id;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                iconLists[index % iconLists.length], // safe
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            SizedBox(
                              width: 70,
                              //height: 100,
                              child: Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return Container();
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Special for you",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            Text("See All", style: TextStyle(color: Colors.grey, fontSize: 15)),
          ],
        ),
        // SizedBox(height: 20),
        SingleChildScrollView(child: ProductList(categoryId: categoryId)),
      ],
    );
  }
}
