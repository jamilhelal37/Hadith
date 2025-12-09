import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/controller/fake_hadeth_cubit/fake_hadeth_cubit.dart';
import 'package:untitled1/model/fake_hadeth_model.dart';
import 'package:untitled1/services/fake_hadeth_repo.dart';


class WrongHadiths extends StatefulWidget {
  const WrongHadiths({super.key});

  @override
  State<WrongHadiths> createState() => _WrongHadithsState();
}

class _WrongHadithsState extends State<WrongHadiths> {


  tt()async{
    List<FakeHadethModel> model= await FakeHadethRepo().getFakeHadeth();
    print(model);

  }
  @override
  void initState() {
   
    super.initState();
   // tt();
  }

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
                child:  state is FakeHadethLooding?  Center(child: CircularProgressIndicator()):
                state is FakeHadethSuccess?
                ListView.builder(itemCount: state.fake_hadeths.length
                ,itemBuilder: (context, index) {
                  return FakeHadethItem(fake_model: state.fake_hadeths[index]);
                  
                },):Center(child: Text('error'))
               )
            ],
          );
        },
      ),
    );
  }
}

class FakeHadethItem extends StatelessWidget {
  const FakeHadethItem({
    super.key, required this.fake_model,
  });

 final FakeHadethModel fake_model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fake_model.text!),
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
              decoration: BoxDecoration(
                color: Color(0xffd0953b),
              ),
              child: Icon(Icons.copy, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
