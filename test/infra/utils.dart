import 'package:mockito/mockito.dart';

const kPicoloValueChangeTopic = 'PICOLO_VALUE_CHANGE';

abstract class PicoloFunctions<T> {
  void onClosed();
  void onSelect(T value);
}

class PicoloFunctionsMock extends Mock implements PicoloFunctions {}
