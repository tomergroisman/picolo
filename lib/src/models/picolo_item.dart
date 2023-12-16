class PicoloItem<T> {
  const PicoloItem({
    required this.label,
    required this.value,
  });

  final String label;
  final T value;
}
