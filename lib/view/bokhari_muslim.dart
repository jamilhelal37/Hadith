import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BokhariMuslim extends StatefulWidget {
  const BokhariMuslim({super.key});

  @override
  State<BokhariMuslim> createState() => _BokhariMuslimState();
}

class _BokhariMuslimState extends State<BokhariMuslim> {
  bool isSelcted = false;
  List<bool> isEnbaled = List.generate(20, (index) => false);

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
                  'البخاري و مسلم',
                  style: TextStyle(
                    color: Color(0xffd0953b),
                    fontFamily: 'cairo',
                    fontSize: 25,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 50,
                    width: 50,

                    child: Icon(CupertinoIcons.moon, color: Color(0xffd0953b)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          SizedBox(
            width: 320,
            child: TextFormField(
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'كلمات البحث ...',
                hintStyle: TextStyle(color: Colors.black.withAlpha(50)),
                hintTextDirection: TextDirection.rtl,
                suffixIcon: Icon(CupertinoIcons.search, color: Colors.green),
                prefixIcon: Icon(Icons.settings_outlined, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.green),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(width: 2, color: Colors.green),
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 70,
            width: 290,
            decoration: BoxDecoration(
              color: Color(0xC3C5FCBC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelcted = isSelcted ? false : true;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: isSelcted
                            ? Color(0xC369E057)
                            : Color(0xC3C5FCBC),
                      ),
                      child: Center(
                        child: Text(
                          'صحيح مسلم',
                          style: TextStyle(
                            color: isSelcted
                                ? Color(0xC3C5FCBC)
                                : Color(0xC369E057),
                            fontSize: 20,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelcted = isSelcted ? false : true;
                      });
                    },
                    child: Container(
                      height: 60,
                      width: 135,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: isSelcted
                            ? Color(0xC3C5FCBC)
                            : Color(0xC369E057),
                      ),
                      child: Center(
                        child: Text(
                          'صحيح البخاري',
                          style: TextStyle(
                            color: isSelcted
                                ? Color(0xC369E057)
                                : Color(0xC3C5FCBC),
                            fontSize: 20,
                            fontFamily: 'cairo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              isEnbaled[index]
                                  ? CupertinoIcons.bookmark_fill
                                  : CupertinoIcons.bookmark,
                            ),
                            onPressed: () {
                              setState(() {
                                isEnbaled[index] = !isEnbaled[index];
                              });
                            },
                          ),
                        ],
                      ),
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
