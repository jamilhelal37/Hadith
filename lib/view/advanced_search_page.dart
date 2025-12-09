import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/model/advanced_search_model.dart';
import 'package:untitled1/model/book_model.dart';
import 'package:untitled1/model/muhaddith_model.dart';
import 'package:untitled1/model/rawi_model.dart';
import 'package:untitled1/model/ruling_model.dart';
import 'package:untitled1/model/subject_model.dart';

import '../controller/advanced_search_cubit/advanced_search_cubit.dart';
import '../controller/advanced_search_cubit/advanced_search_state.dart';
import '../services/advanced_search_repo.dart';
import '../services/book_repo.dart';
import '../services/hadith_repo.dart';
import '../services/rawi_repo.dart';
import '../services/ruling_repo.dart';
import '../services/subject_repo.dart';

class SearchPage extends StatefulWidget {
  final ValueChanged<MuhaddithModel?>? onChangedMuhaddith;
  final MuhaddithModel? initialMuhaddith;
  final ValueChanged<RawiModel?>? onChangedRawi;
  final RawiModel? initialRawi;
  final ValueChanged<SubjectModel?>? onChangedSubject;
  final SubjectModel? initialSubject;
  final ValueChanged<BookModel?>? onChangedBook;
  final BookModel? initialBook;
  final ValueChanged<RulingModel?>? onChangedRuling;
  final RulingModel? initialRuling;

  const SearchPage({
    super.key,
    this.onChangedMuhaddith,
    this.initialMuhaddith,
    this.onChangedRawi,
    this.initialRawi,
    this.onChangedSubject,
    this.initialSubject,
    this.onChangedBook,
    this.initialBook,
    this.onChangedRuling,
    this.initialRuling,
  });

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  MuhaddithModel? selectedMuhaddith;
  RawiModel? selectedRawi;
  SubjectModel? selectedSubject;
  BookModel? selectedBook;
  RulingModel? selectedRuling;

  final MuhaddithRepository _muhaddithRepository = MuhaddithRepository();
  List<MuhaddithModel> _muhaddith = [];
  final RawisRepository _rawisRepository = RawisRepository();
  List<RawiModel> _rawis = [];
  final SubjectsRepository _subjectsRepository = SubjectsRepository();
  List<SubjectModel> _subjects = [];
  final BookRepository _bookRepository = BookRepository();
  List<BookModel> _book = [];
  final RulingRepository _rulingRepository = RulingRepository();
  List<RulingModel> _ruling = [];

  bool _isLoading = false;
  String? _error = '';
  bool _isExpanded = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    selectedMuhaddith = widget.initialMuhaddith;
    selectedRawi = widget.initialRawi;
    selectedSubject = widget.initialSubject;
    selectedBook = widget.initialBook;
    selectedRuling = widget.initialRuling;
    _scrollController.addListener(_onScroll);
    _fetchAll();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final cubit = context.read<AdvancedSearchCubit>();
      if (cubit.state is AdvancedSearchSuccess &&
          (cubit.state as AdvancedSearchSuccess).response.hasMore == true) {
        cubit.loadMore();
      }
    }
  }

  Future<void> _fetchAll() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final muhaddith = await _muhaddithRepository.getAllMuhadiths();
      final rawi = await _rawisRepository.getAllRawis();
      final subject = await _subjectsRepository.getAllSubjects();
      final book = await _bookRepository.getAllBooks();
      final rule = await _rulingRepository.getAllRuling();
      setState(() {
        _muhaddith = muhaddith;
        _rawis = rawi;
        _subjects = subject;
        _book = book;
        _ruling = rule;
        if (widget.initialMuhaddith != null) {
          selectedMuhaddith = _muhaddith.firstWhere(
                (s) => s.id == widget.initialMuhaddith!.id,
            orElse: () => widget.initialMuhaddith!,
          );
        }
        if (widget.initialRawi != null) {
          selectedRawi = _rawis.firstWhere(
                (s) => s.id == widget.initialRawi!.id,
            orElse: () => widget.initialRawi!,
          );
        }
        if (widget.initialSubject != null) {
          selectedSubject = _subjects.firstWhere(
                (s) => s.id == widget.initialSubject!.id,
            orElse: () => widget.initialSubject!,
          );
        }
        if (widget.initialBook != null) {
          selectedBook = _book.firstWhere(
                (s) => s.id == widget.initialBook!.id,
            orElse: () => widget.initialBook!,
          );
        }
        if (widget.initialRuling != null) {
          selectedRuling = _ruling.firstWhere(
                (s) => s.id == widget.initialRuling!.id,
            orElse: () => widget.initialRuling!,
          );
        }
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isEmpty &&
        selectedMuhaddith == null &&
        selectedRawi == null &&
        selectedSubject == null &&
        selectedBook == null &&
        selectedRuling == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال كلمة بحث أو اختيار فلتر واحد على الأقل'),
        ),
      );
      return;
    }

    setState(() {
      _hasSearched = true;
    });

    context.read<AdvancedSearchCubit>().search(
      query: query,
      muhaddithId: selectedMuhaddith?.id,
      rawiId: selectedRawi?.id,
      subjectId: selectedSubject?.id,
      bookId: selectedBook?.id,
      rulingId: selectedRuling?.id,
    );
  }

  void _clearAllFilters() {
    setState(() {
      selectedMuhaddith = null;
      selectedRawi = null;
      selectedSubject = null;
      selectedBook = null;
      selectedRuling = null;
      _searchController.clear();
      _hasSearched = false;
    });

    if (widget.onChangedMuhaddith != null) widget.onChangedMuhaddith!(null);
    if (widget.onChangedRawi != null) widget.onChangedRawi!(null);
    if (widget.onChangedSubject != null) widget.onChangedSubject!(null);
    if (widget.onChangedBook != null) widget.onChangedBook!(null);
    if (widget.onChangedRuling != null) widget.onChangedRuling!(null);

    context.read<AdvancedSearchCubit>().clearSearch();
  }

  void _clearSearchResults() {
    setState(() {
      _hasSearched = false;
    });
    context.read<AdvancedSearchCubit>().clearSearch();
  }

  Widget _buildResultCard(AdvancedSearchResult result) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hadith Number and Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xffd0953b).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'رقم الحديث: ${result.hadithNumber}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'cairo',
                      color: Color(0xffd0953b),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xff4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    result.hadithType,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'cairo',
                      color: Color(0xff4CAF50),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Hadith Text
            Text(
              result.hadithText,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'cairo',
                height: 1.6,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),

            // Metadata
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (result.book != null)
                  _buildMetadataChip('الكتاب: ${result.book!.name}'),
                if (result.rawi != null)
                  _buildMetadataChip('الراوي: ${result.rawi!.name}'),
                if (result.rulingOfMuhaddith != null)
                  _buildMetadataChip('حكم المحدث: ${result.rulingOfMuhaddith!.text}'),
                if (result.finalRuling != null)
                  _buildMetadataChip('الحكم النهائي: ${result.finalRuling!.text}'),
              ],
            ),

            // Explaining (expandable)
            if (result.explaining != null && result.explaining!.text.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'التعليق:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'cairo',
                            color: Color(0xffd0953b),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          result.explaining!.text,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'cairo',
                            height: 1.5,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xfff8dcb8).withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffd0953b).withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontFamily: 'cairo',
          color: Color(0xffd0953b),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdvancedSearchCubit(AdvancedSearchRepository()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfffffde8),
        body: BlocConsumer<AdvancedSearchCubit, AdvancedSearchState>(
          listener: (context, state) {
            if (state is AdvancedSearchError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          height: 50,
                          width: 50,
                          child: Icon(Icons.arrow_back, color: Color(0xffd0953b)),
                        ),
                      ),
                      const Text(
                        'البحث المتقدم',
                        style: TextStyle(
                          color: Color(0xffd0953b),
                          fontFamily: 'cairo',
                          fontSize: 25,
                        ),
                      ),
                      IconButton(
                        onPressed: _clearSearchResults,
                        icon: const Icon(
                          CupertinoIcons.clear,
                          color: Color(0xffd0953b),
                        ),
                        tooltip: 'مسح نتائج البحث',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Search Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _clearAllFilters,
                        icon: const Icon(Icons.clear_all, color: Color(0xffd0953b)),
                        tooltip: 'مسح جميع الفلاتر',
                      ),
                      const Text(
                        'البحث في الموسوعة حسب التفضيلات',
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

                // Search and Filters Section
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _searchController,
                          cursorColor: const Color(0xffd0953b),
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                CupertinoIcons.search,
                                color: Color(0xffd0953b),
                              ),
                              onPressed: _performSearch,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black.withAlpha(100),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffd0953b),
                                width: 2,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffd0953b),
                                width: 2,
                              ),
                            ),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffd0953b),
                                width: 2,
                              ),
                            ),
                            hintTextDirection: TextDirection.rtl,
                            hintText: 'مثلا: صدقة',
                          ),
                          onFieldSubmitted: (value) => _performSearch(),
                        ),
                        const SizedBox(height: 16),

                        // Filters Section
                        ExpansionPanelList(
                          elevation: 0,
                          expandedHeaderPadding: EdgeInsets.zero,
                          dividerColor: Colors.transparent,
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: Colors.transparent,
                              canTapOnHeader: true,
                              isExpanded: _isExpanded,
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return const ListTile(
                                  title: Text(
                                    'الفلاتر',
                                    style: TextStyle(
                                      color: Color(0xffd0953b),
                                      fontFamily: 'cairo',
                                      fontSize: 18,
                                    ),
                                  ),
                                  trailing: Icon(Icons.filter_list, color: Color(0xffd0953b)),
                                );
                              },
                              body: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff8dcb8).withAlpha(100),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DropdownButton<MuhaddithModel>(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      value: selectedMuhaddith,
                                      hint: const Text(
                                        'المحدث',
                                        style: TextStyle(fontFamily: 'cairo'),
                                      ),
                                      items: _muhaddith
                                          .map<DropdownMenuItem<MuhaddithModel>>((
                                          MuhaddithModel model,
                                          ) {
                                        return DropdownMenuItem<MuhaddithModel>(
                                          value: model,
                                          child: Text(
                                            model.name,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'cairo',
                                            ),
                                          ),
                                        );
                                      })
                                          .toList(),
                                      onChanged: (MuhaddithModel? newValue) {
                                        setState(() {
                                          selectedMuhaddith = newValue;
                                        });
                                        if (widget.onChangedMuhaddith != null) {
                                          widget.onChangedMuhaddith!(newValue);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff8dcb8).withAlpha(100),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DropdownButton<RawiModel>(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      value: selectedRawi,
                                      hint: const Text(
                                        'الراوي',
                                        style: TextStyle(fontFamily: 'cairo'),
                                      ),
                                      items: _rawis.map<DropdownMenuItem<RawiModel>>((
                                          RawiModel model,
                                          ) {
                                        return DropdownMenuItem<RawiModel>(
                                          value: model,
                                          child: Text(
                                            model.name,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'cairo',
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (RawiModel? newValue) {
                                        setState(() {
                                          selectedRawi = newValue;
                                        });
                                        if (widget.onChangedRawi != null) {
                                          widget.onChangedRawi!(newValue);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff8dcb8).withAlpha(100),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DropdownButton<SubjectModel>(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      value: selectedSubject,
                                      hint: const Text(
                                        'الموضوع',
                                        style: TextStyle(fontFamily: 'cairo'),
                                      ),
                                      items: _subjects
                                          .map<DropdownMenuItem<SubjectModel>>((
                                          SubjectModel model,
                                          ) {
                                        return DropdownMenuItem<SubjectModel>(
                                          value: model,
                                          child: Text(
                                            model.name,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'cairo',
                                            ),
                                          ),
                                        );
                                      })
                                          .toList(),
                                      onChanged: (SubjectModel? newValue) {
                                        setState(() {
                                          selectedSubject = newValue;
                                        });
                                        if (widget.onChangedSubject != null) {
                                          widget.onChangedSubject!(newValue);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff8dcb8).withAlpha(100),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DropdownButton<BookModel>(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      value: selectedBook,
                                      hint: const Text(
                                        'الكتاب',
                                        style: TextStyle(fontFamily: 'cairo'),
                                      ),
                                      items: _book.map<DropdownMenuItem<BookModel>>((
                                          BookModel model,
                                          ) {
                                        return DropdownMenuItem<BookModel>(
                                          value: model,
                                          child: Text(
                                            model.name,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'cairo',
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (BookModel? newValue) {
                                        setState(() {
                                          selectedBook = newValue;
                                        });
                                        if (widget.onChangedBook != null) {
                                          widget.onChangedBook!(newValue);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff8dcb8).withAlpha(100),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: DropdownButton<RulingModel>(
                                      underline: const SizedBox(),
                                      isExpanded: true,
                                      value: selectedRuling,
                                      hint: const Text(
                                        'الحكم',
                                        style: TextStyle(fontFamily: 'cairo'),
                                      ),
                                      items: _ruling
                                          .map<DropdownMenuItem<RulingModel>>((
                                          RulingModel model,
                                          ) {
                                        return DropdownMenuItem<RulingModel>(
                                          value: model,
                                          child: Text(
                                            model.name,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'cairo',
                                            ),
                                          ),
                                        );
                                      })
                                          .toList(),
                                      onChanged: (RulingModel? newValue) {
                                        setState(() {
                                          selectedRuling = newValue;
                                        });
                                        if (widget.onChangedRuling != null) {
                                          widget.onChangedRuling!(newValue);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Search Button
                                  ElevatedButton(
                                    onPressed: _performSearch,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffd0953b),
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: const Text(
                                      'بحث',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'cairo',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Results Section
                if (_hasSearched) ...[
                  const SizedBox(height: 20),
                  if (state is AdvancedSearchLoading &&
                      state is! AdvancedSearchLoadMore)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffd0953b),
                        ),
                      ),
                    )
                  else if (state is AdvancedSearchSuccess)
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is ScrollEndNotification &&
                              _scrollController.position.pixels ==
                                  _scrollController.position.maxScrollExtent) {
                            context.read<AdvancedSearchCubit>().loadMore();
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              // Results Header
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'عدد النتائج: ${state.response.data.length}',
                                      style: const TextStyle(
                                        fontFamily: 'cairo',
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Text(
                                      'نتائج البحث',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'cairo',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffd0953b),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Results List
                              if (state.response.data.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(40),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 80,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'لا توجد نتائج',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'cairo',
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'حاول تغيير كلمات البحث أو الفلاتر',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'cairo',
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                ...state.response.data.map(_buildResultCard).toList(),

                              // Load More Indicator
                              if (state.response.hasMore == true)
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xffd0953b),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    )
                  else if (state is AdvancedSearchError)
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'حدث خطأ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'cairo',
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: _performSearch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffd0953b),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'إعادة المحاولة',
                                style: TextStyle(fontFamily: 'cairo'),
                              ),
                            ),
                          ],
                        ),
                      ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}