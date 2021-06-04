import 'package:flutter/material.dart';
import 'package:flutter_app/shared/filled_button.dart';

class Gallery extends StatelessWidget {
  final List images;
  final Function? onAddImageClicked;
  final Function? onImageClicked;

  const Gallery({
    required this.images,
    this.onAddImageClicked,
    this.onImageClicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        if (index >= images.length) return _buildAddImage(context);
        return _buildImage(context, images[index]);
      },
      itemCount: images.length + 1,
    );
  }

  Widget _buildImage(context, image) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.7,
      child: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            image,
            fit: BoxFit.fitWidth,
          ),
        ),
        decoration: BoxDecoration(
          color: Color(0xff333333),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddImage(context) {
    return SizedBox(
      width: images.length > 0 ? 130 : MediaQuery.of(context).size.width,
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          child: FilledButton(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Icon(
                Icons.photo_camera_outlined,
                size: 60,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              if (this.onAddImageClicked != null) this.onAddImageClicked!();
            },
          ),
          decoration: BoxDecoration(
            color: Color(0xff333333),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Color(0xff333333),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
      ),
    );
  }
}
