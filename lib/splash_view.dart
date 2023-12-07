import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:taskati/core/styles.dart';
import 'package:taskati/feature/upload_view.dart';
import 'package:taskati/core/app_local_storage.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Future.delayed(const Duration(seconds: 4), () {
        AppLocal.getBool(AppLocal.isUpload).then((value) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const UploadView(),
          ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/logo.json'),
            const SizedBox(height: 30),
            Text('Taskati', style: getTitleStyle()),
            const SizedBox(height: 10),
            Text(
              'It\'s time to get organized',
              style: getSubTitleStyle(),
            )
          ],
        ),
      ),
    );
  }
}
