import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/model/book_model.dart';
import 'package:untitled1/model/muhaddith_model.dart';
import 'package:untitled1/model/rawi_model.dart';
import 'package:untitled1/model/ruling_model.dart';
import 'package:untitled1/model/subject_model.dart';
import 'package:untitled1/services/api_services.dart';

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
  MuhaddithModel? selectedMuhaddith;
  RawiModel? selectedRawi;
  SubjectModel? selectedSubject;
  BookModel? selectedBook;
  RulingModel? selectedRuling;

  final MuhaddithRepository _muhaddithRepository = MuhaddithRepository();
  List<MuhaddithModel> _muhaddith = [];
  final RawisRepository _rawis_repository = RawisRepository();
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

  @override
  void initState() {
    super.initState();
    selectedMuhaddith = widget.initialMuhaddith;
    selectedRawi = widget.initialRawi;
    selectedSubject = widget.initialSubject;
    selectedBook = widget.initialBook;
    selectedRuling = widget.initialRuling;
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final muhaddith = await _muhaddithRepository.getAllMuhadiths();
      final rawi = await _rawis_repository.getAllRawis();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfffffde8),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
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
                    InkWell(
                      onTap: () {},
                      child: const SizedBox(
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
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ExpansionPanelList(
                    elevation: 0,
                    expandedHeaderPadding: EdgeInsets.zero,
                    dividerColor: Colors.transparent,
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _isExpanded = isExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        backgroundColor: Colors.transparent,
                        canTapOnHeader: false,
                        isExpanded: _isExpanded,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 300,
                                child: TextFormField(
                                  cursorColor: const Color(0xffd0953b),
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        CupertinoIcons.search,
                                        color: Color(0xffd0953b),
                                      ),
                                      onPressed: () {},
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
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                        body: Column(
                          children: [
                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              width: 300,
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
                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              width: 300,
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
                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              width: 300,
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
                            const SizedBox(height: 16),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              width: 300,
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
                            const SizedBox(height: 24),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              width: 300,
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
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
