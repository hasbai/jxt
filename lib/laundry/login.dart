import 'package:flutter/material.dart';
import 'package:jxt_toolkits/components/layout.dart';
import 'package:jxt_toolkits/laundry/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../consts.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final phoneNumberController = TextEditingController();
  final verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      appbar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                alignLabelWithHint: true,
              ),
              keyboardType: TextInputType.phone,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
              Expanded(
                child: TextFormField(
                  controller: verificationCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Verification Code',
                    alignLabelWithHint: true,
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: 32),
              ElevatedButton(
                onPressed: () async {
                  await sendVerifyCode(phoneNumberController.text);
                  snackbarKey.currentState?.showSnackBar(
                    const SnackBar(
                      content: Text('Verification code sent'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 48,
                  ),
                ),
                child: const Text('Send', style: TextStyle(fontSize: 18)),
              ),
            ]),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                var token = await login(
                  phoneNumberController.text,
                  verificationCodeController.text,
                );
                snackbarKey.currentState?.showSnackBar(
                  const SnackBar(
                    content: Text('Login successful'),
                  ),
                );
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString(tokenNames[Pages.laundry]!, token);
                navigatorKeys[Pages.laundry]?.currentState?.pop();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
    );
  }
}