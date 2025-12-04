import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WrongHadiths extends StatelessWidget {
  const WrongHadiths({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 50,
                    width: 50,

                    child: Icon(Icons.arrow_back, color: Color(0xffd0953b)),
                  ),
                ),
                Text(
                  'احاديث منتشرة لا تصح',
                  style: TextStyle(
                    color: Color(0xffd0953b),
                    fontFamily: 'cairo',
                    fontSize: 25,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 50,
                        width: 40,

                        child: Icon(
                          CupertinoIcons.search,
                          color: Color(0xffd0953b),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 50,
                        width: 40,

                        child: Icon(
                          CupertinoIcons.moon,
                          color: Color(0xffd0953b),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  'راجعها واعتمد الحكم عليها المشرف العام',
                  style: TextStyle(
                    color: Colors.red.withAlpha(250),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'cairo',
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              itemCount: 3,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 12,
                mainAxisExtent: 400,
              ),
              padding: EdgeInsets.symmetric(horizontal: 30),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black.withAlpha(50),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('data'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: Color(0xffd0953b),
                            icon: Icon(Icons.share),
                            onPressed: () {},
                          ),
                          Container(
                            width: 70,
                            height: 50,
                            decoration: BoxDecoration(color: Color(0xffd0953b)),
                            child: Icon(Icons.copy, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
