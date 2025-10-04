import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/category/presentation/widgets/cetegory_list.dart';
// import 'package:flutter_ecom_api/features/product/presentation/bloc/product_bloc.dart';
// import 'package:flutter_ecom_api/features/product/presentation/bloc/product_event.dart';
// import 'package:flutter_ecom_api/features/product/presentation/bloc/product_state.dart';
// import 'package:flutter_ecom_api/features/product/presentation/pages/detail_page.dart';
// import 'package:flutter_ecom_api/features/product/presentation/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<String> bannerImages = [
    "https://mir-s3-cdn-cf.behance.net/project_modules/fs/3ce709113389695.60269c221352f.jpg",
    "https://picsum.photos/id/1016/800/400",
    "https://picsum.photos/id/1018/800/400",
    "https://picsum.photos/id/1021/800/400",
  ];

  @override
  void initState() {
    super.initState();
    //context.read<ProductBloc>().add(FetchProductEvent(categoryId: 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //SizedBox(height: 40),
              ListTile(
                contentPadding: EdgeInsets.only(left: 0, right: 0),
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.dashboard),
                ),
                trailing: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200,
                  ),
                  child: Icon(Icons.notifications_outlined),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 5),
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black38,
                    ),
                    suffixIcon: SizedBox(
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 2,
                            height: 30,
                            color: Colors.black38,
                          ),
                          Icon(
                            Icons.filter_list,
                            size: 30,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 5, top: 10, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Stack(
                        children: [
                          CarouselSlider.builder(
                            itemCount: bannerImages.length,
                            itemBuilder: (_, index, __) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(bannerImages[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              onPageChanged: (index, _) {
                                selectedIndex = index;
                                setState(() {});
                              },
                              autoPlay: true,
                              viewportFraction: 1,
                              height: 200,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              autoPlayInterval: Duration(seconds: 4),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 40,
                              child: DotsIndicator(
                                dotsCount: bannerImages.length,
                                position: selectedIndex.toDouble(),
                                animate: true,
                                decorator: DotsDecorator(
                                  activeSize: Size(18, 8),
                                  size: Size(8, 8),
                                  activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  color: Colors.transparent,
                                  activeColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  spacing: EdgeInsets.only(
                                    right: 3,
                                    top: 11,
                                    bottom: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              //Category display
              CategoryList(),

              //SizedBox(height: 20),

              //specially for you
              /*
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Special for you",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "See All",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                  */
              /*
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 150),
                    width: double.infinity,
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          );
                        }

                        if (state is ProductErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.errorMessage),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }

                        if (state is ProductLoadedState) {
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
                        }
                        return Container();
                      },
                    ),
                  ),
                  */
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  /*
  Widget _builCategoryUI(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.deepPurple.shade200,
          child: Icon(icon, color: Colors.deepPurple),
        ),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }
  */
}
