class PictureEntry {

  final String imageSrc;
  final String photographerName;
  final String altTitle;

  const PictureEntry({
    required this.imageSrc,
    required this.photographerName,
    required this.altTitle,
  });


  factory PictureEntry.fromJson(Map<String, dynamic> json) {

    return PictureEntry(
      imageSrc: json['src']['small'],
      photographerName: json['photographer'],
      altTitle: json['alt'] ?? '',
    );
  }

}