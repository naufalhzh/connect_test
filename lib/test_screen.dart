import 'package:connect_test/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(TestScreen(connectivity: Connectivity()));

class TestScreen extends StatelessWidget {
  final Connectivity connectivity;

  const TestScreen({Key? key, required this.connectivity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(connectivity: connectivity),
      child: MaterialApp(
        title: 'Connectivity cubit',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Connectivity cubit spotlight'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                    if (state is InternetConnected &&
                        state.connectionType == ConnectionType.wifi) {
                      return const Text(
                        'Wifi',
                        style: TextStyle(color: Colors.green, fontSize: 30),
                      );
                    } else if (state is InternetConnected &&
                        state.connectionType == ConnectionType.mobile) {
                      return const Text(
                        'Mobile',
                        style: TextStyle(color: Colors.yellow, fontSize: 30),
                      );
                    } else if (state is InternetDisconnected) {
                      return const Text(
                        'Disconnected',
                        style: TextStyle(color: Colors.red, fontSize: 30),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}