// lib/screens/muhaddith_grid_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled1/generated/assets.dart';
import 'package:untitled1/model/about_muhaddith_model.dart';

import '../services/about_muhaddith_repo.dart';
import 'muhaddith_detail_screen.dart';

class AboutMuhaddithScreen extends StatefulWidget {
  const AboutMuhaddithScreen({Key? key}) : super(key: key);

  @override
  State<AboutMuhaddithScreen> createState() => _AboutMuhaddithScreenState();
}

class _AboutMuhaddithScreenState extends State<AboutMuhaddithScreen> {
  final AboutMuhaddithRepo _repo = AboutMuhaddithRepo();
  List<AboutMuhaddithModel> _muhaddiths = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchMuhaddiths();
  }

  Future<void> _fetchMuhaddiths() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final muhaddiths = await _repo.getAllAboutMuhadith();
      setState(() {
        _muhaddiths = muhaddiths;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffffde8),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.imagesBg4),
            fit: BoxFit.fill,
          ),
          boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,offset: Offset(5, 0))]
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Color(0xfffffde8)),
              child: Padding(
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
                      'تراجم المحدثين',
                      style: TextStyle(
                        color: Color(0xffd0953b),
                        fontFamily: 'cairo',
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 50, width: 50),
                  ],
                ),
              ),
            ),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return SizedBox(
        width: 150,
        height: 150,
        child: LottieBuilder.asset(Assets.imagesLoading1),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: LottieBuilder.asset(Assets.imagesQuestionmark),
            ),
            Text(
              'خطأ في تحميل البيانات',
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchMuhaddiths,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffd0953b),
                foregroundColor: Colors.white,
              ),
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    if (_muhaddiths.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_search, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'لا توجد بيانات',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: _muhaddiths.length,
      itemBuilder: (context, index) {
        final muhaddith = _muhaddiths[index];
        return _MuhaddithCard(
          muhaddith: muhaddith,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MuhaddithDetailScreen(muhaddith: muhaddith),
              ),
            );
          },
        );
      },
    );
  }
}

class _MuhaddithCard extends StatelessWidget {
  final AboutMuhaddithModel muhaddith;
  final VoidCallback onTap;

  const _MuhaddithCard({required this.muhaddith, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xfffffde8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              const SizedBox(height: 12),
              Text(
                muhaddith.name ?? 'غير معروف',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'cairo',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffd0953b),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xffd0953b),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'عرض التفاصيل',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_back_ios_new,
                      size: 12,
                      color: Colors.white,
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
