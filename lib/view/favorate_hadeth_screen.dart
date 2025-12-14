// favorites_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/view/widgets/favorite_button.dart';

import '../controller/favorate_cubit.dart/favorate_cubit.dart';
import '../model/advanced_search_model.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoriteCubit _favoriteCubit;

  @override
  void initState() {
    super.initState();
    _favoriteCubit = FavoriteCubit();
    _favoriteCubit.getFavorites();
  }

  @override
  void dispose() {
    _favoriteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _favoriteCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Favorite Hadiths'),
          centerTitle: true,
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is FavoriteError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      state.message,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _favoriteCubit.getFavorites(),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }
                                        
            if (state is FavoritesLoaded) {
              final favorites = state.favorites;

              if (favorites.favorites.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 64,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No favorite hadiths yet',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap the heart icon on any hadith to add it here',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: favorites.favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites.favorites[index];
                  final hadith = favorite.hadithData;

                  if (hadith == null) {
                    return ListTile(
                      title: Text('Hadith #${favorite.hadithId}'),
                      trailing: FavoriteButton(
                        hadithId: favorite.hadithId,
                        initialIsFavorite: true,
                      ),
                    );
                  }

                  return _buildFavoriteHadithCard(hadith, favorite.id);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteHadithCard(AdvancedSearchResult hadith, int favoriteId) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hadith #${hadith.hadithNumber}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                FavoriteButton(
                  hadithId: hadith.id,
                  initialIsFavorite: true,
                ),
              ],
            ),

            SizedBox(height: 12),

            Text(
              hadith.hadithText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(height: 1.5),
            ),

            SizedBox(height: 12),

            // Row(
            //   children: [
            //     Icon(Icons.access_time, size: 14, color: Colors.grey),
            //     SizedBox(width: 4),
            //     Text(
            //       'Added on ${DateFormat('MMM dd, yyyy').format(favorite.createdAt)}',
            //       style: TextStyle(fontSize: 12, color: Colors.grey),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}