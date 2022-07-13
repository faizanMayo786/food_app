import 'package:flutter/material.dart';
import 'package:food_app/src/blocs/coupon_bloc.dart';
import 'package:provider/provider.dart';

import '../../widget/inbox/coupon_tab.dart';
import '../../widget/inbox/message_tab.dart';
import '../../widget/inbox/promotion_tab.dart';

// ignore: must_be_immutable
class InboxScreen extends StatefulWidget {
  InboxScreen(this.appBarSize, this.context, {Key? key}) : super(key: key);
  double appBarSize;
  // ignore: prefer_typing_uninitialized_variables
  var context;
  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  double boxSize = 0;
  int? index;

  Future<void> getData() async {
    await context.read<CouponBloc>().fetchCoupon();
    return Future.delayed(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          print(snapshot);
          if (context.watch<CouponBloc>().coupon.isEmpty) {
            return RefreshIndicator(
              onRefresh: getData,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Coupon"),
                  ],
                ),
              ),
            );
          }
          return SingleChildScrollView(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      height: 30,
                      child: LayoutBuilder(builder: (context, constraint) {
                        boxSize = constraint.maxHeight;
                        return TabBar(
                            labelStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                            indicator: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            unselectedLabelColor: Colors.black,
                            tabs: const [
                              Tab(
                                text: 'Messages',
                              ),
                              Tab(
                                text: 'Coupons',
                              ),
                              Tab(
                                text: 'Promotions',
                              )
                            ]);
                      }),
                    ),
                  ),
                  // Center(
                  //   child: ToggleSwitch(
                  //     fontSize: 18.0,
                  //     cornerRadius: 5.0,
                  //     totalSwitches: 3,
                  //     initialLabelIndex: 0,
                  //     minWidth: 350.0,
                  //     labels: const ['Messages', 'Coupons', 'Promotions'],
                  //     onToggle: (index) {
                  //       if (kDebugMode) {
                  //         print('switched to: $index');
                  //       }
                  //     },
                  //     activeBgColor: const [Colors.orange],
                  //     inactiveBgColor: Colors.white,
                  //   ),
                  // ),
                  SizedBox(
                    height: (MediaQuery.of(context).size.height -
                        widget.appBarSize -
                        (boxSize + 100)),
                    child: LayoutBuilder(builder: (context, constarints) {
                      var coupon2 = context.watch<CouponBloc>().coupon;

                      return RefreshIndicator(
                        onRefresh: getData,
                        child: TabBarView(
                          children: [
                            MessageTab(),
                            CouponTab(coupon: coupon2),
                            PromotionTab(),
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        });
  }
}
