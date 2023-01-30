import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrscanner/pages/tab_pages/generate_qr_page.dart';
import 'package:qrscanner/pages/tab_pages/scan_qr_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: const SafeArea(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              children: [ScanQrPage(), GenerateQrPage()],
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 64.0,
            child: TabBar(
              splashBorderRadius: BorderRadius.circular(16.0),
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.camera_alt_outlined,
                  ),
                  text: 'Escanear',
                ),
                Tab(
                  icon: Icon(
                    Icons.qr_code,
                  ),
                  text: 'Generar',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
