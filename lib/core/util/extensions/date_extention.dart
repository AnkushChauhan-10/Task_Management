extension ToDate on String {
  DateTime get toDate => DateTime.parse(this);
}

extension ToString on DateTime {
  String get toStringDate =>
      '$month/$day/$year $hour:${minute.toString().padLeft(2, '0')}';
}
