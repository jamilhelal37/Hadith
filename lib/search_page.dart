import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? selectedMuhaddith;

  String? selectedRawi;

  String? selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
              child: Row(
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
                    'الرئيسية',
                    style: TextStyle(
                      color: Color(0xffd0953b),
                      fontFamily: 'cairo',
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'البحث في الموسوعة بأي كلمة',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'cairo',
                      fontSize: 20,
                      color: Color(0xffd0953b),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    cursorColor: Color(0xffd0953b),
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.black.withAlpha(100)),
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
                      hintText: 'مثلا: صدقة',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SingleChildScrollView(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  color: Color(0xfff8dcb8).withAlpha(100),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedMuhaddith,
                        hint: Text('المحدث'),
                        items: ['البخاري', 'مسلم', 'الترمذي', 'النسائي']
                            .map(
                              (muhaddith) => DropdownMenuItem(
                            value: muhaddith,
                            child: Text(muhaddith),
                          ),
                        )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedMuhaddith = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(
                      width: 120,
                      child:  DropdownButton<String>(
                        isExpanded: true,
                        value: selectedRawi,
                        hint: Text('الراوي'),
                        items: ['أبو هريرة', 'عائشة', 'عمر بن الخطاب', 'علي بن أبي طالب']
                            .map((rawi) => DropdownMenuItem(
                          value: rawi,
                          child: Text(rawi),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRawi = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(
                      width: 120,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedSubject,
                        hint: Text('المحدث'),
                        items: ['البخاري', 'مسلم', 'الترمذي', 'النسائي']
                            .map(
                              (muhaddith) => DropdownMenuItem(
                            value: muhaddith,
                            child: Text(muhaddith),
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSubject = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
