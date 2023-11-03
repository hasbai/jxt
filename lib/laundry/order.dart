import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';

import '../components/loading.dart';
import 'api.dart';
import 'model.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({
    super.key,
    required this.sku,
    required this.machine,
    required this.time
  });

  final Sku sku;
  final WashingMachine machine;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        appbar: const AppbarWithBackButton(title: "Order"),
        body: FutureBuilder<bool>(
          future: createOrder(sku, machine, time),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: Wrap(
                direction: Axis.vertical,
                spacing: 16,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("Created order. Please go to the WeChat app to pay."),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: const Text("Back to home")
                  )
                ]
            ));
          },
        )
    );
  }
}

