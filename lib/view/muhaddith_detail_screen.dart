// lib/screens/muhaddith_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:untitled1/model/about_muhaddith_model.dart';

class MuhaddithDetailScreen extends StatelessWidget {
  final AboutMuhaddithModel muhaddith;

  const MuhaddithDetailScreen({Key? key, required this.muhaddith})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfffffde8),
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
                  'تفاصيل المحدث',
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
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Directionality(textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with name and icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xffFCF0D5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xffd0953b)),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'المحدث',
                                style: TextStyle(
                                  fontFamily: 'cairo',
                                  fontSize: 14,
                                  color: Color(0xffd0953b),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                muhaddith.name ?? 'غير معروف',
                                style: const TextStyle(
                                  fontFamily: 'cairo',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffd0953b),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // About Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xffd0953b),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'نبذة عن المحدث',
                              style: TextStyle(
                                fontFamily: 'cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffd0953b),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Divider(color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        Text(
                          muhaddith.about ?? 'لا توجد معلومات',
                          style: const TextStyle(
                            fontFamily: 'cairo',
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),

      // Floating Action Button for sharing (optional)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Share functionality
          _showShareOptions(context);
        },
        backgroundColor: Color(0xffd0953b),
        child: const Icon(Icons.share, color: Colors.white),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'مشاركة معلومات ${muhaddith.name}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.copy, color: Color(0xffd0953b)),
                title: const Text('نسخ النص'),
                onTap: () {
                  Navigator.pop(context);
                  toastification.show(
                    context: context,
                    title: Text('تم نسخ النص '),
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Color(0xffd0953b)),
                title: const Text('مشاركة'),
                onTap: () {
                  Navigator.pop(context);
                  // Implement share functionality
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
