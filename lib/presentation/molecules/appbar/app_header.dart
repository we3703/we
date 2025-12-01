import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/foundations/icon_radio.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? titleWidget; // Reintroduce titleWidget
  final Color backgroundColor;
  final double elevation;
  final VoidCallback? onBackButtonPressed;
  final bool showSearchAction;
  final ValueChanged<String>? onSearchSubmitted;
  final String searchHintText;
  final bool searchAtStart;

  const AppHeader({
    super.key,
    this.title,
    this.showBackButton = false,
    this.actions,
    this.titleWidget, // Reintroduce titleWidget
    this.backgroundColor = AppColors.surface,
    this.elevation = 0,
    this.onBackButtonPressed,
    this.showSearchAction = false,
    this.onSearchSubmitted,
    this.searchHintText = '검색어를 입력해주세요',
    this.searchAtStart = false,
  }) : assert(
          title == null || titleWidget == null,
          'Cannot provide both a title and a titleWidget',
        );

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppHeaderState extends State<AppHeader> {
  bool _isSearchMode = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _enterSearchMode() {
    setState(() {
      _isSearchMode = true;
    });
  }

  void _exitSearchMode() {
    setState(() {
      _isSearchMode = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isSearchMode) {
      return AppBar(
        backgroundColor: widget.backgroundColor,
        elevation: widget.elevation,
        leading: IconButton(
          icon: const AppIcon.size24(icon: Icons.arrow_back_ios),
          onPressed: _exitSearchMode,
        ),
        title: TextField(
          controller: _searchController,
          onSubmitted: widget.onSearchSubmitted,
          autofocus: true,
          decoration: InputDecoration(
            hintText: widget.searchHintText,
            hintStyle: AppTextStyles.bodyRegular.copyWith(
              color: AppColors.textDisabled,
            ),
            filled: true, // Added for SearchBar implementation
            fillColor: AppColors.subSurface, // Added for SearchBar implementation
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Added for SearchBar implementation
              borderSide: BorderSide.none, // Added for SearchBar implementation
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          style: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false, // Align title to the left
        automaticallyImplyLeading: false,
      );
    }

    final List<Widget> currentActions = List.from(widget.actions ?? []);
    if (widget.showSearchAction) {
      final searchButton = IconButton(
        icon: const AppIcon.size24(icon: Icons.search),
        onPressed: _enterSearchMode,
      );
      if (widget.searchAtStart) {
        currentActions.insert(0, searchButton);
      } else {
        currentActions.add(searchButton);
      }
    }

    return AppBar(
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      leading: widget.showBackButton
          ? IconButton(
              icon: const AppIcon.size24(icon: Icons.arrow_back_ios),
              onPressed:
                  widget.onBackButtonPressed ??
                  () => Navigator.of(context).pop(),
            )
          : null,
      title: widget.titleWidget ?? (widget.title != null
          ? Text(widget.title!, style: AppTextStyles.heading3Bold)
          : null),
      actions: currentActions,
      centerTitle: false, // Align title to the left
      automaticallyImplyLeading: false,
    );
  }
}
