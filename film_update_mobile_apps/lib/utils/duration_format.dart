String durationFormat({required int runtime}) {
  int hour = runtime ~/ 60;
  int minute = runtime % 60;

// format string "2h 5m"
  String formatString = '${hour}h ${minute}m';

// cetak hasilnya
  return formatString;
}
