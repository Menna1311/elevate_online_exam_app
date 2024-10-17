import 'package:elevate_online_exam_app/di/di.dart';
import 'package:elevate_online_exam_app/presentaion/utils.dart';
import 'package:elevate_online_exam_app/presentaion/views/foreget_password_viewmodel.dart';
import 'package:elevate_online_exam_app/presentaion/views/widgets/verify_otp.dart';
import 'package:elevate_online_exam_app/presentaion/views/widgets/verify_password.dart';
import 'package:elevate_online_exam_app/presentaion/views/widgets/vreify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  ForegetPasswordViewmodel viewModel = getIt.get<ForegetPasswordViewmodel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final _passwordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Password',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<ForegetPasswordViewmodel, ForgetPasswordState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is VerifyOtpState) {
              return Center(
                child: VerifyOtpWidget(
                  emailController: _emailController,
                  otpControllers: _controllers,
                  focusNodes: _focusNodes,
                  verifyOtp: (String email, String otp) {
                    verifyOtp(_emailController.text, otp);
                  },
                  sendOtp: (String email) {
                    sendOtp(_emailController.text);
                  },
                ),
              );
            }
            if (state is ResetPasswordState) {
              return VerifyPasswordWidget(
                screenWidth: screenWidth,
                exception: state.error,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                formKey: _passwordFormKey,
                emailController: _emailController,
                onResetPassword: (String email, String password) {
                  resetPassword(
                    _emailController.text,
                    _passwordController.text,
                  );
                  showCustomDialog(context,
                      message: 'password changed successfully',
                      title: 'Password changed');
                },
              );
            }

            if (state is InitialState) {
              return Center(
                child: VerifyEmail(
                  sendOtp: (String) {
                    sendOtp(_emailController.text);
                  },
                  emailController: _emailController,
                ),
              );
            }
            if (state is SuccessState) {
              showCustomDialog(context,
                  message: 'password changed successfully',
                  title: 'Password changed');
            }
            return Center(
              child: VerifyEmail(
                sendOtp: (String) {
                  sendOtp(_emailController.text);
                },
                emailController: _emailController,
              ),
            );
          },
        ),
      ),
    );
  }

  void sendOtp(String email) {
    viewModel.doIntent(VerifyEmailIntent(email));
  }

  void verifyOtp(String email, String otp) {
    viewModel.doIntent(VerifyOtpIntent(email, otp));
  }

  void resetPassword(String email, String newPassword) {
    viewModel.doIntent(ResetPasswordIntent(email, newPassword));
  }
}
