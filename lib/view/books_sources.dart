import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/generated/assets.dart';
import 'package:untitled1/model/book_model.dart';

import '../services/book_repo.dart';

class BooksSources extends StatefulWidget {
  const BooksSources({super.key});

  @override
  State<BooksSources> createState() => _BooksSourcesState();
}

BookModel? bookModel;

class _BooksSourcesState extends State<BooksSources> {
  final BookRepository _bookRepository = BookRepository();
  List<BookModel> _book = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBook();
  }

  Future<void> fetchBook() async {
    final model = await _bookRepository.getAllBooks();
    setState(() {
      _book = model;
    });
  }

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
            Directionality(
              textDirection: TextDirection.rtl,
              child: Expanded(
                child: _book.isNotEmpty
                    ? ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ListTile(
                                  leading: Icon(Icons.book_outlined),
                                  title: Text(
                                    _book[index].name.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'cairo',
                                      color: Color(0xffd0953b),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          );
                        },
                      )
                    : SizedBox(
                        width: double.infinity,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Lottie.asset(Assets.imagesLoading1),
                            ),
                            Text(
                              'الرجاء الانتظار ..',
                              style: TextStyle(
                                color: Color(0xffd0953b),
                                fontSize: 25,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
