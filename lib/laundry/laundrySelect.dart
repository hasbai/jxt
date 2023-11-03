import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';

import '../components/loading.dart';
import 'api.dart';
import 'model.dart';

class LaundrySelect extends StatefulWidget {
  const LaundrySelect({super.key});

  @override
  State<LaundrySelect> createState() => _LaundrySelect();
}

class _LaundrySelect extends State<LaundrySelect> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      appbar: AppBar(
        title: const Text('Select Laundry'),
      ),
      body: FutureBuilder<List<LaundryRoom>>(
        future: getLaundryRooms(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data![index].name),
                onTap: () {
                  Navigator.of(context).pop(snapshot.data![index]);
                }
              );
            },
          );
          },
        ),
      );
  }
}
