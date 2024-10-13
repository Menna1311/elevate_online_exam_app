import 'package:flutter/material.dart';

class VerifyEmail extends StatelessWidget {
  final Exception? exception;
  final TextEditingController emailController;
  final void Function(String) sendOtp;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerifyEmail({
    super.key,
    this.exception,
    required this.emailController,
    required this.sendOtp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Forget password',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Please enter your email associated to\nyour account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailPattern =
                    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                if (!emailPattern.hasMatch(value)) {
                  return 'Invalid Email';
                }
                return null;
              },
              controller: emailController,
              decoration: InputDecoration(
                label: const Text('Email'),
                hintText: 'Enter your email',
                errorText: exception != null ? 'This Email is not valid' : null,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            if (exception != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'There was an error: ${exception.toString()}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendOtp(emailController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: exception == null
                      ? const Color(0xFF02369C)
                      : const Color(0xFF878787),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
