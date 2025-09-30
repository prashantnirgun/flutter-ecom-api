import 'package:flutter/material.dart';
import 'package:flutter_ecom_api/core/utils/formatters.dart';

class ProductCard extends StatefulWidget {
  final String imgPath;
  final String name;
  final String price;
  final VoidCallback onPress;

  const ProductCard({
    super.key,
    required this.imgPath,
    required this.name,
    required this.price,
    required this.onPress,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedIndex = 0;

  List<Color> mColors = [Colors.black, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      widget.imgPath,
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Spacer(),
                  Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    softWrap: false,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        Formatters.currency(
                          double.parse(widget.price),
                          decimalPlaces: 0,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 14,
                        child: Row(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: mColors.length,
                              itemBuilder: (BuildContext _, int index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: selectedIndex == index
                                      ? Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: mColors[index],
                                              width: 1,
                                            ),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                            ),
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: mColors[index],
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 0,
                                          ),
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: mColors[index],
                                          ),
                                        ),
                                );
                              },
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 0),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  "+2",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
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
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
