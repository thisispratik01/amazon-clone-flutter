import 'package:amazone_clone/common/widgets/loader.dart';
import 'package:amazone_clone/features/home/services/home_services.dart';
import 'package:amazone_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazone_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealofDay extends StatefulWidget {
  const DealofDay({Key? key}) : super(key: key);

  @override
  State<DealofDay> createState() => _DealofDayState();
}

class _DealofDayState extends State<DealofDay> {
  Product? product;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductDetailScreen.routeName,
                      arguments: product);
                },
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      child: const Text(
                        "Deal of the Day",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Image.network(
                      product!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '\$${product!.price.toString()}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, right: 40, top: 5),
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: product!.images
                            .map(
                              (e) => Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                height: 100,
                                width: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
