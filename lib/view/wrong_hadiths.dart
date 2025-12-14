import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/controller/fake_hadeth_cubit/fake_hadeth_cubit.dart';
import 'package:untitled1/model/fake_hadeth_model.dart';
import 'package:untitled1/services/fake_hadeth_repo.dart';

import '../generated/assets.dart';

class WrongHadiths extends StatefulWidget {
  const WrongHadiths({super.key});

  @override
  State<WrongHadiths> createState() => _WrongHadithsState();
}

class _WrongHadithsState extends State<WrongHadiths> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FakeHadethCubit>(context).getFakeHadeths();
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: BlocBuilder<FakeHadethCubit, FakeHadethState>(
        builder: (context, state) {
          return Column(
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: SizedBox(
                        height: 50,
                        width: 40,
                        child: Icon(
                          CupertinoIcons.search,
                          color: Color(0xffd0953b),
                        ),
                      ),
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
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      cursorColor: Color(0xffd0953b),
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black.withAlpha(100),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffd0953b),
                            width: 2,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffd0953b),
                            width: 2,
                          ),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffd0953b),
                            width: 2,
                          ),
                        ),
                        hintTextDirection: TextDirection.rtl,
                        hintText: 'ابحث عن الحديث',
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: state is FakeHadethLooding
                    ? SizedBox(
                        width: 150,
                        height: 150,
                        child: Lottie.asset(Assets.imagesLoading1),
                      )
                    : state is FakeHadethSuccess
                        ? ListView.builder(
                            itemCount: state.fake_hadeths.length,
                            itemBuilder: (context, index) {
                              return FakeHadethItem(
                                fake_model: state.fake_hadeths[index],
                              );
                            },
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Lottie.asset(Assets.imagesQuestionmark),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'لم يتم العثور على نتائج',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'cairo',
                                  color: Color(0xffd0953b),
                                ),
                              ),
                            ],
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class FakeHadethItem extends StatefulWidget {
  const FakeHadethItem({super.key, required this.fake_model});

  final FakeHadethModel fake_model;

  @override
  State<FakeHadethItem> createState() => _FakeHadethItemState();
}

class _FakeHadethItemState extends State<FakeHadethItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // النص الرئيسي
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.fake_model.text!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'cairo',
                  ),
                ),
              ),
              // الحكم
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  'الحكم :${widget.fake_model.ruling!.text!}',
                  style: TextStyle(fontSize: 15, fontFamily: 'cairo'),
                ),
              ),
              // ExpansionPanel لعرض subValid
              if (widget.fake_model.subValid != null &&
                  widget.fake_model.subValid!.text != null &&
                  widget.fake_model.subValid!.text!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xffd0953b).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'الصحيح البديل',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo',
                          color: Color(0xffd0953b),
                        ),
                      ),
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      childrenPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      initiallyExpanded: false,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _isExpanded = expanded;
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            widget.fake_model.subValid!.text!,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'cairo',
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // الأزرار في الأسفل
              Padding(
                padding: const EdgeInsets.only(left: 4, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      color: Color(0xffd0953b),
                      icon: Icon(size: 28, Icons.share),
                      onPressed: () {},
                    ),
                    Container(
                      width: 65,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xffd0953b),
                      ),
                      child: Icon(Icons.copy, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
