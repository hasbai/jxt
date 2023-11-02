import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';
import 'package:jxt_toolkits/components/loading.dart';
import 'package:jxt_toolkits/laundry/model.dart';

import '../components/toggleButtons.dart';
import 'client.dart';

class SkuPage extends StatefulWidget {
  const SkuPage(this.machine, {super.key});

  final WashingMachine machine;

  @override
  State<SkuPage> createState() => _SkuPage();
}

class _SkuPage extends State<SkuPage> {
  int selectedSku = 0;
  int selectedTime = 0;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        appbar: AppbarWithBackButton(title: widget.machine.name),
        body: FutureBuilder<List<Sku>>(
          future: getSkus(widget.machine.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return ui(snapshot.data!);
          },
        ));
  }

  Widget ui(List<Sku> data) {
    return Column(children: [
      Expanded(
        flex: 1,
        child: ListView(children: [
          Text("Select function", style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          WrappedToggleButton(
              items: [for(var sku in data ) sku.name],
              selected: selectedSku,
              onSelect: (i) => {setState(() {selectedSku = i;},)},
          ),
          const SizedBox(height: 12),
          Wrap(children: [
            Text(
            data[selectedSku].description,
            style: Theme.of(context).textTheme.bodySmall),
          ]),
          const SizedBox(height: 8),
          const Divider(height: 2, color: Colors.grey),
          const SizedBox(height: 8),
          Text("Select time", style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 4),
          WrappedToggleButton(
            items: [for(var i in data[selectedSku].items ) "${i.minutes} min"
                ],
            selected: selectedTime,
            onSelect: (i) => {setState(() {selectedTime = i;},)},
          ),
        ],
        )
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: [
            Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment:  CrossAxisAlignment.baseline,
              children: [
              Text("Total:  ", style: Theme.of(context).textTheme.bodyLarge),
              Text(data[selectedSku].items[selectedTime].price,
                  style: Theme.of(context).textTheme.displayLarge
              ),
            ]),
            const Spacer(),
            OutlinedButton(
              onPressed: ()=>{},
              style: OutlinedButton.styleFrom(
                fixedSize: const Size(160, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ), // Border color
              ),
              child: const Text("Order", style: TextStyle(fontSize: 30))
            )
          ],
        ),
      )
    ]);
  }
}

