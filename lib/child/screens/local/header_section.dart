import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key key, this.title, this.home = false})
      : super(key: key);

  final String title;
  final bool home;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ),
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4), BlendMode.dstATop),
          image: AssetImage('assets/cover.jpg'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  !home
                      ? Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )
                      : Container(),
                  SizedBox(width: 20.0),
                  Text(
                    'LOGO',
                    style: TextStyle(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 7,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                title ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
