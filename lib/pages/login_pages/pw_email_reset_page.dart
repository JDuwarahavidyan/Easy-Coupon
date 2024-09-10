import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:floating_snackbar/floating_snackbar.dart';

class PasswordEmailResetPage extends StatefulWidget {
  const PasswordEmailResetPage({super.key});

  @override
  _PasswordEmailResetPageState createState() => _PasswordEmailResetPageState();
}

class _PasswordEmailResetPageState extends State<PasswordEmailResetPage> {
  final TextEditingController emailController = TextEditingController();

  void navigateWithAnimation(BuildContext context, String routeName) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getRouteWidget(routeName),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1.0, 0.0); // Start the animation from left to right
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  Widget _getRouteWidget(String routeName) {
    if (routeName == RouteNames.login) {
      return LoginPage();
    }
    return const Scaffold();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: size.height * 0.05,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  navigateWithAnimation(context, RouteNames.login);
                },
                child: const Icon(
                  CupertinoIcons.back,
                  size: 30,
                  color: Color(0xFF294B29),
                ),
              ),
            ),
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
              top: size.height * 0.40,
              left: 40,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "ENTER YOUR EMAIL TO\nRESET YOUR PASSWORD",
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
              top: size.height * 0.5,
              left: 40,
              right: 40,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Enter the Email",
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (!mounted) return; // Ensure the widget is still mounted

                      if (state is ResetEmailSent) {
                        floatingSnackBar(
                          context: context,
                          message: 'Reset email sent. Check your inbox.',
                          backgroundColor: Colors.green,
                        );
                        navigateWithAnimation(context, RouteNames.login);
                      }
                    },
                    builder: (context, state) {
                      bool isLoading = state is AuthStateLoading;

                      return ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                final email = emailController.text;
                                if (email.isEmpty) {
                                  floatingSnackBar(
                                    context: context,
                                    message: 'Please enter your email',
                                    backgroundColor: Colors.redAccent,
                                  );
                                  return;
                                }
                                context.read<AuthBloc>().add(
                                      ForgotPasswordEvent(email: email),
                                    );
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
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )
                              : const Text(
                                  "SEND EMAIL",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}