import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/generated/assets.dart';
import '../controller/search_cubit/search_cubit.dart';
import '../controller/search_cubit/search_state.dart';
import '../model/search_model.dart';

class GeneralSearch extends StatefulWidget {
  const GeneralSearch({super.key});

  @override
  State<GeneralSearch> createState() => _GeneralSearchState();
}

class _GeneralSearchState extends State<GeneralSearch> {
  final TextEditingController _searchController = TextEditingController();
  late HadithCubit _hadithCubit;
  final Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://apibykassem.onrender.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type':'application/json',
          'Accept':'application/json',
        },
      ),
    );

    _hadithCubit = HadithCubit(dio: dio);
  }

  void _toggleExplanation(int hadithId) {
    setState(() {
      _expandedStates[hadithId] = !(_expandedStates[hadithId] ?? false);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _hadithCubit.close();
    super.dispose();
  }

  void _searchHadith(String query) {
    if (query.isNotEmpty) {
      _hadithCubit.searchHadith(query);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _hadithCubit.clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _hadithCubit,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfffffde8),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              // Your existing header UI remains the same
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
                      'البحث العام',
                      style: TextStyle(
                        color: Color(0xffd0953b),
                        fontFamily: 'cairo',
                        fontSize: 25,
                      ),
                    ),
                    InkWell(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.arrow_back, color: Color(0xfffffde8)),
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
                      controller: _searchController,
                      onFieldSubmitted: _searchHadith,
                      cursorColor: Color(0xffd0953b),
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () => _searchHadith,
                          icon: Icon(
                            CupertinoIcons.search,
                            color: Color(0xffd0953b),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: _clearSearch,
                        ),
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
                        hintText: 'مثلا: صدقة',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: BlocBuilder<HadithCubit, HadithState>(
                  builder: (context, state) {
                    return _buildContent(state);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(HadithState state) {
    switch (state) {
      case HadithInitial():
        return _buildInitialState();
      case HadithLoading():
        return _buildLoadingState();
      case HadithSuccess():
        return _buildSuccessState(state.hadithModel);
      case HadithError():
        return _buildErrorState(state.message);
      default:
        return Container();
    }
  }

  Widget _buildInitialState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(height: 150, width: 150, Assets.imagesSearch),
        Center(
          child: Text(
            'اكتب كلمة للبحث في الأحاديث',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 18,
              color: Color(0xffd0953b),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 16),
          Lottie.asset(Assets.imagesLoading1, height: 150, width: 150),
          Text(
            textDirection: TextDirection.rtl,
            'جاري البحث...',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 20,
              color: Color(0xffd0953b),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(HadithModel hadithModel) {
    if (hadithModel.data.isEmpty) {
      return Column(
        children: [
          SizedBox(height: 24),
          Lottie.asset(Assets.imagesQuestionmark, width: 100, height: 100),
          SizedBox(height: 12),
          Center(
            child: Text(
              'لا توجد نتائج للبحث',
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 18,
                color: Color(0xffd0953b),
              ),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: hadithModel.data.length,
      itemBuilder: (context, index) {
        final hadith = hadithModel.data[index];
        return _buildHadithCard(hadith);
      },
    );
  }

  Widget _buildHadithCard(Hadith hadith) {
    final isExpanded = _expandedStates[hadith.id] ?? false;
    return Card(

      color: Color(0xffFEF7FF),
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Hadith Text
                if (hadith.hadithText != null)
                  Padding(
                    padding: const EdgeInsets.only(left:14,right: 14,top: 14,bottom: 6),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        hadith.hadithText!,
                        textDirection: TextDirection.rtl,
                        maxLines: 100,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                // Book and Rawi info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (hadith.book?.name != null)
                          Text(
                            'الكتاب: ${hadith.book!.name!}',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: hadith.book!.name!.length > 15 ? 10 : 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        if (hadith.hadithType != null)
                          Text(
                            'نوع الحديث :${hadith.hadithType!}',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                      ],
                    ),
                    if (hadith.rulingOfMuhaddith?.text != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (hadith.book?.name != null)
                            Text(
                              'حكم المحدث : ${hadith.rulingOfMuhaddith!.text}',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                          if (hadith.rawi?.name != null)
                            Text(
                              'الحكم النهائي :${hadith.finalRuling!.text}',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 13,
                                color: Colors.grey[700],
                              ),
                            ),
                        ],
                      ),
                    Row(
                      children: [
                        if (hadith.rawi?.name != null)
                          Text(
                            'الراوي: ${hadith.rawi!.name!}',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        if (hadith.hadithNumber?.toString() != null)
                          Text(
                            'رقم الحديث: ${hadith.hadithNumber!}',
                            style: TextStyle(
                              fontFamily: 'cairo',
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                      ],
                    ),
                  ],),
                ),
              ],
            ),
          ),

          Directionality(
            textDirection: TextDirection.rtl,
            child: ExpansionPanelList(
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              expansionCallback: (panelIndex, isExpanded) {
                _toggleExplanation(hadith.id ?? 0);
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Column(children: []);
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (hadith.explaining?.text != null)
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xfffef8e8),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xffd0953b),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'الشرح:',
                                  style: TextStyle(
                                    fontFamily: 'cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffd0953b),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  hadith.explaining!.text!,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'cairo',
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Add other details here (rulings, etc.)
                      ],
                    ),
                  ),
                  isExpanded: isExpanded,
                  canTapOnHeader: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // In your _GeneralSearchState class, update the _buildErrorState method:

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Assets.imagesQuestionmark, width: 100, height: 100),
            SizedBox(height: 16),
            Text(
              'خطأ في الاتصال',
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 12),

            Text(
              textDirection: TextDirection.rtl,
              'يرجى التأكد من أن:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              textDirection: TextDirection.rtl,
              '• عنوان API صحيح\n• اتصال بالإنترنت\n• أن الخادم يعمل',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'cairo',
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_searchController.text.isNotEmpty) {
                  _searchHadith(_searchController.text);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffd0953b),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'إعادة المحاولة',
                style: TextStyle(
                  fontFamily: 'cairo',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
