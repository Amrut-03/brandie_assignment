import 'package:flutter/material.dart';

class ExpandableTitleText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const ExpandableTitleText({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  State<ExpandableTitleText> createState() => _ExpandableTitleTextState();
}

class _ExpandableTitleTextState extends State<ExpandableTitleText> {
  final ValueNotifier<bool> _expandedNotifier = ValueNotifier(false);

  @override
  void dispose() {
    _expandedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _expandedNotifier.value = !_expandedNotifier.value;
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: _expandedNotifier,
        builder: (context, expanded, child) {
          return Text(
            widget.text,
            textAlign: TextAlign.justify,
            maxLines: expanded ? 2 : 1,
            overflow:
            expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: widget.style,
          );
        },
      ),
    );
  }
}