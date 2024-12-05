class PictureEntry {

  final String imageSrc;
  final String photographer;
  final String altTitle;

  const PictureEntry({
    required this.imageSrc,
    required this.photographer,
    required this.altTitle,
  });


  factory PictureEntry.fromJson(Map<String, dynamic> json) {

    return PictureEntry(
      imageSrc: json['src']['small'],
      photographer: json['photographer'],
      altTitle: json['alt'] ?? '',
    );
  }

}