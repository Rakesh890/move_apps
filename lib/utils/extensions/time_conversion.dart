extension MinutesExtension on int {
  String toHoursAndMinutes() {
    if (this < 0) {
      throw ArgumentError("Input should be a non-negative integer");
    }

    final hours = this ~/ 60;
    final minutes = this % 60;

    if (hours > 0 && minutes > 0) {
      return '$hours ${hours == 1 ? 'h':'h'}  $minutes ${minutes == 1 ? 'm':'m'}';
    } else if (hours > 0) {
      return '$hours ${hours == 1 ? 'h':'h'}';
    } else {
      return '$minutes ${minutes == 1 ? 'm':'m'}';
    }
  }
}