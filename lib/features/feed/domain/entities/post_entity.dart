class CaptionEntity {
  final String text;
  final bool isBold;

  const CaptionEntity({
    required this.text,
    this.isBold = false,
  });
}

class PostEntity {
  final String post;
  final String musicLabel;
  final String musicHighlight;
  final String musicSuffix;
  final List<CaptionEntity> caption;
  final String referralCode;

  const PostEntity({
    required this.post,
    required this.musicLabel,
    required this.musicHighlight,
    required this.musicSuffix,
    required this.caption,
    required this.referralCode,
  });
}