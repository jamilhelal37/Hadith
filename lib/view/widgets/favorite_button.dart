// favorite_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controller/favorate_cubit.dart/favorate_cubit.dart';

class FavoriteButton extends StatefulWidget {
  final int hadithId;
  final bool initialIsFavorite;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  const FavoriteButton({
    Key? key,
    required this.hadithId,
    this.initialIsFavorite = false,
    this.size = 24.0,
    this.activeColor,
    this.inactiveColor,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initialIsFavorite;
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final cubit = context.read<FavoriteCubit>();
    final isFav = await cubit.isFavorite(widget.hadithId);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  void _toggleFavorite() async {
    final cubit = context.read<FavoriteCubit>();

    if (_isFavorite) {
      await cubit.removeFromFavorites(widget.hadithId);
      if (mounted) {
        setState(() {
          _isFavorite = false;
        });
      }
    } else {
      await cubit.addToFavorites(widget.hadithId);
      if (mounted) {
        setState(() {
          _isFavorite = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteCubit, FavoriteState>(
      listener: (context, state) {
        if (state is FavoriteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: IconButton(
        onPressed: _toggleFavorite,
        icon: Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite
              ? (widget.activeColor ?? Colors.red)
              : (widget.inactiveColor ?? Colors.grey),
          size: widget.size,
        ),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints(
          minWidth: widget.size + 8,
          minHeight: widget.size + 8,
        ),
      ),
    );
  }
}