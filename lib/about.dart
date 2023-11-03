import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        appbar: AppBar(title: const Text('About')),
        body: const Center(child:
          Expanded(child:
            Text("This is JXT's toolkits.\n"
                "One tool is for booking the laundry room.\n"
                "More features are currently under development..."
              ),
          )
        )
    );
  }
}