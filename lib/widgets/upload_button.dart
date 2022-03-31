import 'package:flutter/material.dart';

class PhotoUploadButton extends StatefulWidget {
  const PhotoUploadButton({
    this.count = 0,
    this.shouldAllowMultiple = true,
  });

  final int count;
  final bool shouldAllowMultiple;

  @override
  State<PhotoUploadButton> createState() => _PhotoUploadButtonState();
}

class _PhotoUploadButtonState extends State<PhotoUploadButton> {
  String _computeButtonText() {
    if (widget.count == 0) {
      if (widget.shouldAllowMultiple) {
        return 'Upload Photos';
      } else {
        return 'Upload Photo';
      }
    } else {
      if (widget.shouldAllowMultiple) {
        return 'Upload More';
      } else {
        return 'Choose Another';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = _computeButtonText();

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.camera, color: Theme.of(context).primaryColor),
          Text(
            '     $text',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}