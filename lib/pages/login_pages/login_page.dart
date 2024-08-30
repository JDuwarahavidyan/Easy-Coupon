import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:easy_coupon/routes/route_names.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Controllers for username and password text fields
    final TextEditingController userNameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void navigateWithAnimation(BuildContext context, String routeName) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            switch (routeName) {
              case RouteNames.resetPW:
                return const NewUserPwResetPage();
              case RouteNames.student:
                return  StudentHomeScreen();
              // case RouteNames.canteenA:
              //   return const CanteenAHomeScreen();
              // case RouteNames.canteenB:
              //   return const CanteenBHomeScreen();
              default:
                return const LoginPage();
            }
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1),
        ),
      );
    }

    return Scaffold(
      body: Background(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: size.height * 0.06,
              right: -40,
              child: Container(
                width: size.width * 0.6,
                child: Image.asset(
                  "assets/images/landing/main.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.25,
              left: 40,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF294B29),
                    fontSize: 36,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.32,
              left: 40,
              right: 40,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is FirstTimeLogin) {
                    navigateWithAnimation(context, RouteNames.resetPW);
                  } else if (state is StudentAuthenticated) {
                    navigateWithAnimation(context, RouteNames.student);
                  // } else if (state is CanteenAAuthenticated) {
                  //   navigateWithAnimation(context, RouteNames.canteenA);
                  // } else if (state is CanteenBAuthenticated) {
                  //   navigateWithAnimation(context, RouteNames.canteenB);
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
                        controller: userNameController,
                        decoration: const InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: size.height * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          final userName =
                              userNameController.text.toLowerCase();
                          final password = passwordController.text;

                          if (userName.isEmpty || password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('All fields are required')),
                            );
                            return;
                          }

                          context.read<AuthBloc>().add(
                                LoggedInEvent(
                                  username: userName,
                                  password: password,
                                ),
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
                          child: const Text(
                            "LOGIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, RouteNames.resetPWEmail);
                        },
                        child: const Text(
                          "Forgot your password?",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF294B29),
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
