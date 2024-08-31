import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:floating_snackbar/floating_snackbar.dart';

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
        resizeToAvoidBottomInset: false,
      body: Background(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: size.height * 0.1,
              right: -20,
              child: SizedBox(
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
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 1),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            LoginPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(
                            CurveTween(curve: curve),
                          );

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  } else if (state is AuthStateError) {
                    floatingSnackBar(
                      context: context,
                      message: state.error,
                      backgroundColor: Colors.redAccent,
                    );
                  }
                },
                builder: (context, state) {
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
                        onPressed: state is AuthStateLoading
                            ? null
                            : () {
                                if (currentPasswordController.text.isEmpty ||
                                    newPasswordController.text.isEmpty ||
                                    confirmPasswordController.text.isEmpty) {
                                  floatingSnackBar(
                                    context: context,
                                    message: 'All fields are required',
                                    backgroundColor: Colors.redAccent,
                                  );
                                  return;
                                }
                                if (currentPasswordController.text ==
                                    newPasswordController.text) {
                                  floatingSnackBar(
                                    context: context,
                                    message:
                                        'New password cannot be the same as the current password',
                                    backgroundColor: Colors.redAccent,
                                  );
                                  return;
                                }
                                if (newPasswordController.text ==
                                    confirmPasswordController.text) {
                                  context.read<AuthBloc>().add(
                                        UpdatePasswordEvent(
                                          currentPassword:
                                              currentPasswordController.text,
                                          newPassword:
                                              newPasswordController.text,
                                        ),
                                      );
                                } else {
                                  floatingSnackBar(
                                    context: context,
                                    message: 'New passwords do not match',
                                    backgroundColor: Colors.redAccent,
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
                          padding: const EdgeInsets.all(1),
                          child: state is AuthStateLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text(
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












