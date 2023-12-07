import 'package:flutter/material.dart';
import 'package:picolo/picolo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Picolo Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Picolo<num>(
              items: [
                PickerItem(label: 'One', value: 1),
                PickerItem(label: 'Two', value: 2),
                PickerItem(label: 'Three', value: 3),
              ],
              selectedValue: 1,
              onSelect: (value) {
                print('Value changed: $value');
              },
            ).show(context: context);
          },
          child: const Text('Open Picker'),
        ),
      ),
    );
  }
}
