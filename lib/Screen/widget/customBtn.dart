import 'package:flutter/material.dart';

class customBtn extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool isLoading;

  const customBtn(
      {Key key, this.title, this.onPressed, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
      onTap:onPressed,
      child:   Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Container(
              height:50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color(0xffff3a5a),
                
                ),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _isLoading?false:true,
                      child: Center(
                        child: Text(title
                        ,style: TextStyle(
                          fontSize :16.0,
                         color: Colors.white,
                         fontWeight: FontWeight.w500
                        )),
                    )),
                    Visibility(
                      visible: _isLoading,
                      child: Center(
                        child: SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                          )),
                    )
                  ],
                ),
                ))
      );
    
  }
}
