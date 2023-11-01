import 'package:flutter/material.dart';

import '../components/loading.dart';
import 'client.dart';
import 'model.dart';

class WashingMachineList extends StatefulWidget {
  const WashingMachineList(this.laundryID, {super.key});
  final int laundryID;
  @override
  State<WashingMachineList> createState() => _WashingMachineList();
}

class _WashingMachineList extends State<WashingMachineList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future(() {
            setState(() {});
          });
        },
        child: FutureBuilder<List<WashingMachine>>(
          future: getWashingMachines(widget.laundryID),
          builder: (context, snapshot) {
            if (widget.laundryID == 0) {
              return const Text('');
            } else if (!snapshot.hasData) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return WashingMachineInfo(snapshot.data![index]);
              },
            );
          },
        ));
  }
}

const stateIdle = 1;

class WashingMachineInfo extends StatelessWidget {
  const WashingMachineInfo(this.obj, {super.key});
  final WashingMachine obj;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            obj.category == categoryDryingMachine
                ? const Icon(Icons.local_fire_department)
                : const Icon(Icons.local_laundry_service),
            const SizedBox(width: 16),
            Text(obj.name),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                boxShadow: [
                  BoxShadow(
                    color: (obj.state == stateIdle ? Colors.green : Colors.red)
                        .withAlpha(128),
                    blurRadius: 4,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.circle,
                color: obj.state == stateIdle
                    ? Colors.green[600]
                    : Colors.red[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
