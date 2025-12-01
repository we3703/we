import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/typography.dart';

class SearchInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  const SearchInput({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _internalController;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    _internalController.addListener(_updateClearButtonVisibility);
  }

  @override
  void didUpdateWidget(covariant SearchInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_updateClearButtonVisibility);
      _internalController.removeListener(_updateClearButtonVisibility);
      _internalController = widget.controller ?? TextEditingController();
      _internalController.addListener(_updateClearButtonVisibility);
    }
  }

  void _updateClearButtonVisibility() {
    final bool hasText = _internalController.text.isNotEmpty;
    if (_showClearButton != hasText) {
      setState(() {
        _showClearButton = hasText;
      });
    }
  }

  void _clearText() {
    _internalController.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return TextFormField(
      controller: _internalController,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      style: AppTextStyles.bodyRegular.copyWith(color: AppColors.textPrimary),
      decoration: InputDecoration()
          .applyDefaults(inputTheme)
          .copyWith(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.search, color: AppColors.textDisabled),
            suffixIcon: _showClearButton
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.textDisabled,
                    ),
                    onPressed: _clearText,
                  )
                : null,
          ),
    );
  }

  @override
  void dispose() {
    _internalController.removeListener(_updateClearButtonVisibility);
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }
}
