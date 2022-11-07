import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String status = " ";

  late StreamSubscription subscription;

  Future<void> checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.mobile) {
      setState(() {
        status = "Mobile Network";
        if (kDebugMode) {
          print("Wifi Network");
        }
      });
    } else if (result == ConnectivityResult.wifi) {
      setState(() {
        status = "Wifi Network";
        if (kDebugMode) {
          print("Wifi Network");
        }
      });
    } else if (result == ConnectivityResult.none) {
      setState(() {
        status = "No Network Connection";
        if (kDebugMode) {
          print("Wifi Network");
        }
      });
    }
  }

  @override
  void initState() {
    checkConnectivity();

    subscription = Connectivity().onConnectivityChanged.listen(
      (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connectivity Changed ${result.name}"),
          ),
        );
        setState(() {
          status = result.name; 
          print('');
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Status $status"),
      ),
    );
  }
}
