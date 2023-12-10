import 'package:mockito/mockito.dart';

abstract class PicoloFunctions<T> {
  void onClosed();
  void onSelect(T value);
}

class PicoloFunctionsMock extends Mock implements PicoloFunctions {}
