import 'package:flutter/material.dart';

class imageSwipe extends StatefulWidget {
  final List imageList;

  const imageSwipe({Key key, this.imageList}) : super(key: key);
  @override
  _imageSwipeState createState() => _imageSwipeState();
}

class _imageSwipeState extends State<imageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                Container(
                    child: Image.asset(
                      widget.imageList[i],
                      fit: BoxFit.cover,
                    ))
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300
                    ),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                    width: _selectedPage == i ? 25.0 : 12.0,
                    height: 12.0,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
