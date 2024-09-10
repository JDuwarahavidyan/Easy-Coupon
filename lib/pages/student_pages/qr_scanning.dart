import 'package:easy_coupon/bloc/qr/qr_bloc.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:easy_coupon/pages/student_pages/confirmation_page.dart';
import 'package:easy_coupon/pages/student_pages/student_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class QrPage extends StatefulWidget {
  final int val;
  final String studentUserId;
  final String studentUserName;
  const QrPage(
      {super.key,
      required this.val,
      required this.studentUserId,
      required this.studentUserName});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = '';
  Barcode? result;
  int loops = 0;

  // Define static key and IV
  final key = encrypt.Key.fromUtf8('easycouponkey@ruhunaengfac22TDDS');
  final iv = encrypt.IV.fromUtf8('easyduwarahan#27');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      controller = qrViewController;
    });
    controller?.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null && loops <= 0) {
        final scannedData = result?.code;
        if (scannedData != null) {
          final decryptedData = decryptData(scannedData);
          if (decryptedData != null) {
            context.read<UserBloc>().add(FetchUserRoleEvent(decryptedData));
            context
                .read<UserBloc>()
                .add(FetchCanteenUserNameEvent(decryptedData));
          } else {
            _showInvalidQRDialog();
          }
          loops++;
        } else {
          _showInvalidQRDialog();
          loops++;
        }
      }
    });
  }

  String? decryptData(String encryptedData) {
    try {   
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
      final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
      return decrypted;
    } catch (e) {
      return null;
    }
  }
  
  void _showConfirmationDialog(String role, int val, String canteenUserId, String canteenUsername) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Use Coupon?'),
          content: Text(
              'Do you want to use $val ${val == 1 ? 'coupon' : 'coupons'} at ${role == 'canteena' ? 'Kalderama' : 'Hilton'}?'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateBackToStudentPage(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('Confirm'),
              onPressed: () {
                final scannedTime = DateTime.now();

                final qrCode = QRModel(
                  studentId: widget.studentUserId,
                  canteenId: canteenUserId,
                  canteenType: role,
                  studentName: widget.studentUserName, 
                  canteenName: canteenUsername, 
                  scannedAt: scannedTime,
                  count: val,
                );
                context
                    .read<UserBloc>()
                    .add(ScannedDataEvent(result!, val, widget.studentUserId));
                context
                    .read<UserBloc>()
                    .add(UpdateCanteenCountEvent(val, canteenUserId));
                context.read<QrCodeBloc>().add(CreateQrCodeEvent(qrCode));
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      val: val,
                      role: role,
                      canteenUserId: canteenUserId,
                      scannedTime: scannedTime,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showInvalidQRDialog() {
    controller?.pauseCamera(); 
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Invalid QR Code'),
          content:
              const Text('The scanned QR code is not valid. Please try again.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                loops = 0;
                Navigator.of(context).pop();
                _navigateBackToStudentPage(context);
                Future.delayed(const Duration(seconds: 1), () {
                  controller
                      ?.resumeCamera(); 
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateBackToStudentPage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
              StudentMainPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var curvedAnimation = CurvedAnimation(
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
      (Route<dynamic> route) => false,
    );
  }
  String? userRole;
  String? canteenUserId;
  String? canteenUsername;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserRoleFetched) {
                setState(() {
                  userRole = state.role;
                  canteenUserId = decryptData(result?.code ?? '');
                });
                if (userRole != null && canteenUsername != null) {
                  _showConfirmationDialog(userRole!, widget.val, canteenUserId!, canteenUsername!);
                }
              } else if (state is UserFailure) {
                _showInvalidQRDialog();
              }
            },
          ),
            BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is CanteenUserNameFetched) {
                setState(() {
                  canteenUsername = state.canteenUserName;
                });
                if (userRole != null && canteenUsername != null) {
                  _showConfirmationDialog(userRole!, widget.val, canteenUserId!, canteenUsername!);
                }
              } else if (state is UserFailure) {
                _showInvalidQRDialog();
              }
            },
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserRoleLoading || state is CanteenUserNameLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: <Widget>[
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.transparent,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                CustomPaint(
                  painter: ScannerOverlayPainter(),
                  child: Container(),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 30),
                    onPressed: () {
                      _navigateBackToStudentPage(context);
                    },
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: 0,
                  right: 0,
                  child: const Column(
                    children: [
                      Text(
                        'Place the QR Code inside the area',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Scanning will start automatically',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final cutOutRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.width * 0.8,
        height: size.width * 0.8,
      ),
      const Radius.circular(20),
    );

    final path = Path()
      ..addRect(rect)
      ..addRRect(cutOutRect)
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}