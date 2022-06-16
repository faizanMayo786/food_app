import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  int? index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   elevation: 0,
        //   leading: Icon(
        //             Icons.arrow_back,
        //             color: AppColor.themeSecondary,
        //             size: 20.0,
        //           ),
        //   title: const Text("Inbox"),
        //   actions: const [

        //     // Padding(
        //     //   padding: EdgeInsets.only(right: 8.0),
        //     //   child: Icon(Icons.more_vert_rounded),
        //     // )
        //   ],

        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ToggleSwitch(
                fontSize: 18.0,
                cornerRadius: 5.0,
                totalSwitches: 3,
                initialLabelIndex: 0,
                minWidth: 350.0,
                labels: const ['Messages', 'Coupons', 'Promotions'],
                onToggle: (index) {
                  if (kDebugMode) {
                    print('switched to: $index');
                  }
                },
                activeBgColor: const [Colors.orange],
                inactiveBgColor: Colors.white,
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}