// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/util/custom_page_route.dart';
import '../../model/item.dart';
import '../../screens/item/item_detail_screen.dart';

class ItemDealSlider extends StatefulWidget {
  ItemDealSlider({Key? key, required this.items}) : super(key: key);
  List items;
  @override
  State<ItemDealSlider> createState() => ItemDealSliderState();
}

class ItemDealSliderState extends State<ItemDealSlider> {
  int activeindex = 0;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  Widget buildImage(String urlImage, int index) => SizedBox(
          child: Image.network(
        urlImage,
        fit: BoxFit.none,
        scale: 2,
        width: 334,
      ));

  buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeindex,
        effect: WormEffect(
          type: WormType.thin,
          dotHeight: 9,
          dotWidth: 9,
          dotColor: Colors.white.withOpacity(0.5),
          activeDotColor: Colors.orange,
        ),
        count: widget.items.length,
      );
  @override
  Widget build(BuildContext context) {
    return widget.items.isNotEmpty
        ? SizedBox(
            height: 188,
            width: 334,
            child: Column(
              children: [
                Container(
                  width: 334,
                  height: 188,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.deepOrange,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 334,
                          height: 188,
                          child: CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              onPageChanged: (index, reason) => setState(
                                () => activeindex = index,
                              ),
                            ),
                            items: widget.items.map(
                              (e) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 334,
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              CustomPageRoute(
                                                builder: MenuItemScreen(
                                                  item: Item(
                                                    id: widget
                                                        .items[activeindex].id,
                                                    name: widget
                                                        .items[activeindex]
                                                        .name,
                                                    description: widget
                                                        .items[activeindex]
                                                        .description,
                                                    imageUrl: widget
                                                        .items[activeindex]
                                                        .imageUrl,
                                                    price: widget
                                                        .items[activeindex]
                                                        .price,
                                                    status: widget
                                                        .items[activeindex]
                                                        .status,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: buildImage(e.imageUrl, 0)),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 334,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4.0,
                                      horizontal: 8,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              widget.items[activeindex].name ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              widget.items[activeindex]
                                                      .description ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: buildIndicator(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
