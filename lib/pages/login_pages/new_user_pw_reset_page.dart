import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/routes/routes.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewUserPwResetPage extends StatefulWidget {
  const NewUserPwResetPage({super.key});

  @override
  State<NewUserPwResetPage> createState() => _NewUserPwResetPageState();
}

class _NewUserPwResetPageState extends State<NewUserPwResetPage> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: size.height * 0.1,
              right: -20,
              child: Container(
                width: size.width * 0.6,
                child: Image.asset(
                  "assets/images/landing/pw.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.2,
              left: 40,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "RESET YOUR\nPASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF294B29),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.4,
              left: 40,
              right: 40,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is PasswordUpdated) {
                    Navigator.pushReplacementNamed(context, RouteNames.login);
                  } else if (state is AuthStateError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthStateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: <Widget>[
                      TextField(
                        controller: currentPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Current Password",
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      TextField(
                        controller: newPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "New Password",
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Confirm Password",
                        ),
                      ),
                      SizedBox(height: size.height * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          if (currentPasswordController.text.isEmpty ||
                              newPasswordController.text.isEmpty ||
                              confirmPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All fields are required'),
                              ),
                            );
                            return;
                          }
                          if (currentPasswordController.text ==
                              newPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'New password cannot be the same as the current password'),
                              ),
                            );
                            return;
                          }
                          if (newPasswordController.text ==
                              confirmPasswordController.text) {
                            context.read<AuthBloc>().add(
                                  UpdatePasswordEvent(
                                    currentPassword:
                                        currentPasswordController.text,
                                    newPassword: newPasswordController.text,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('New passwords do not match')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                          padding: EdgeInsets.zero,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF294B29),
                                Color(0xFF50623A),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "RESET PASSWORD",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
