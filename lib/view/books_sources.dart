import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BooksSources extends StatefulWidget {
  const BooksSources({super.key});

  @override
  State<BooksSources> createState() => _BooksSourcesState();
}

class _BooksSourcesState extends State<BooksSources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    'الكتب و المصادر ',
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
                      child: Icon(
                        CupertinoIcons.moon,
                        color: Color(0xffd0953b),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Directionality(textDirection: TextDirection.rtl,
              child: Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ListTile(
                          onTap: (){},
                          leading: Icon(Icons.book_outlined),
                          title: Text('Book Name',style: TextStyle(fontFamily: 'cairo',color: Color(0xffd0953b)),),
                          subtitle: Text('description'),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },),
              ),
            )
          ],
        ),
      ),
    );
  }
}
