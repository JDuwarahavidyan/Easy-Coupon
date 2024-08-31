import 'package:easy_coupon/pages/login_pages/fg_pw.dart';
import 'package:easy_coupon/pages/login_pages/pw_reset.dart';
import 'package:easy_coupon/pages/student_pages/home.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/routes/route_names.dart';

class SignInThree extends StatelessWidget {
  SignInThree({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void navigateWithAnimation(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          switch (routeName) {
            case RouteNames.pwreset:
              return const PwReset();
            case RouteNames.home:
              return const StudentHome();
            case RouteNames.canteen:
              return const StudentHome();
            /*case RouteNames.canteenB:
              return const CanteenBHomeScreen();*/
            default:
              return SignInThree(); // Updated to new login page class
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                child: Text(
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
                    navigateWithAnimation(context, RouteNames.pwreset);
                  } else if (state is StudentAuthenticated) {
                    navigateWithAnimation(context, RouteNames.home);
                  } else if (state is CanteenAAuthenticated) {
                    navigateWithAnimation(context, RouteNames.home);//need to change
                  } /*else if (state is CanteenBAuthenticated) {
                    navigateWithAnimation(context, RouteNames.canteenB);
                  }*/ else if (state is AuthStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
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
                        decoration: InputDecoration(
                          labelText: "Username",
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: size.height * 0.05),
                      ElevatedButton(
                        onPressed: () {
                          final userName = userNameController.text.toLowerCase();
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
                          textStyle: TextStyle(
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
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF294B29),
                                Color(0xFF50623A),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: Text(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Forget()),
                          );
                        },
                        child: Text(
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
