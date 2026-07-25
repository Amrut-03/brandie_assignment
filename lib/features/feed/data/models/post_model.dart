import '../../domain/entities/post_entity.dart';

class CaptionModel extends CaptionEntity {
  const CaptionModel({
    required super.text,
    super.isBold,
  });

  factory CaptionModel.fromJson(Map<String, dynamic> json) {
    return CaptionModel(
      text: json['text'],
      isBold: json['isBold'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isBold': isBold,
    };
  }
}

class PostModel extends PostEntity {
  const PostModel({
    required super.post,
    required super.musicLabel,
    required super.musicHighlight,
    required super.musicSuffix,
    required super.caption,
    required super.referralCode,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      post: json['post'],
      musicLabel: json['musicLabel'],
      musicHighlight: json['musicHighlight'],
      musicSuffix: json['musicSuffix'],
      caption: (json['caption'] as List)
          .map((e) => CaptionModel.fromJson(e))
          .toList(),
      referralCode: json['referralCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post': post,
      'musicLabel': musicLabel,
      'musicHighlight': musicHighlight,
      'musicSuffix': musicSuffix,
      'caption': caption
          .map((e) => {
        'text': e.text,
        'isBold': e.isBold,
      })
          .toList(),
      'referralCode': referralCode,
    };
  }
}