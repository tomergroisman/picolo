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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PicoloController<num> picoloController = PicoloController();
  num? selectedValue;

  @override
  void initState() {
    selectedValue = picoloController.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: Picolo<num>(
                items: [
                  PicoloItem(label: 'One', value: 1),
                  PicoloItem(label: 'Two', value: 2),
                  PicoloItem(label: 'Three', value: 3),
                ],
                controller: picoloController,
                onSelect: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
                pickerInputDecoration: const InputDecoration(
                  label: Text("Test Picker"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Picked Value (Controller): ${picoloController.selectedValue}'),
            Text('Picked Value (Local State): $selectedValue'),
          ],
        ),
      ),
    );
  }
}
