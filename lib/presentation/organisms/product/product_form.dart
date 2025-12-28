import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';

class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController categoryController;
  final TextEditingController priceController;
  final TextEditingController salePriceController;
  final TextEditingController descriptionController;
  final TextEditingController detailDescriptionController;
  final TextEditingController stockController;
  final bool isAvailable;
  final List<String> existingImageUrls;
  final List<XFile> selectedImages;
  final VoidCallback onPickImages;
  final Function(int) onRemoveExistingImage;
  final Function(int) onRemoveNewImage;
  final Function(bool) onAvailabilityChanged;
  final VoidCallback onSave;
  final bool isEdit;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.categoryController,
    required this.priceController,
    required this.salePriceController,
    required this.descriptionController,
    required this.detailDescriptionController,
    required this.stockController,
    required this.isAvailable,
    required this.existingImageUrls,
    required this.selectedImages,
    required this.onPickImages,
    required this.onRemoveExistingImage,
    required this.onRemoveNewImage,
    required this.onAvailabilityChanged,
    required this.onSave,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildBasicInfoSection(),
          const SizedBox(height: AppSpacing.space20),
          const Divider(),
          const SizedBox(height: AppSpacing.space20),
          _buildDetailSection(),
          const SizedBox(height: AppSpacing.space20),
          const Divider(),
          const SizedBox(height: AppSpacing.space20),
          _buildImageSection(),
          const SizedBox(height: AppSpacing.space20),
          const Divider(),
          const SizedBox(height: AppSpacing.space20),
          _buildSalesSettingSection(),
          const SizedBox(height: AppSpacing.space32),
          PrimaryButton(
            text: isEdit ? '수정하기' : '생성하기',
            onPressed: onSave,
          ),
          const SizedBox(height: AppSpacing.space20),
        ],
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('기본 정보', style: AppTextStyles.heading3Bold),
        const SizedBox(height: AppSpacing.space20),
        TextInput(
          controller: nameController,
          labelText: '제품명',
          hintText: '제품명을 입력하세요',
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '제품명을 입력해주세요';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.layoutPadding),
        TextInput(
          controller: categoryController,
          labelText: '카테고리',
          hintText: '카테고리를 입력하세요',
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '카테고리를 입력해주세요';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.layoutPadding),
        TextInput(
          controller: priceController,
          labelText: '정가',
          hintText: '정가를 입력하세요',
          isRequired: true,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '정가를 입력해주세요';
            }
            if (int.tryParse(value) == null) {
              return '올바른 숫자를 입력해주세요';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.layoutPadding),
        TextInput(
          controller: salePriceController,
          labelText: '할인가',
          hintText: '할인가를 입력하세요 (0이면 할인 없음)',
          isRequired: false,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              if (int.tryParse(value) == null) {
                return '올바른 숫자를 입력해주세요';
              }
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.layoutPadding),
        TextInput(
          controller: stockController,
          labelText: '재고',
          hintText: '재고를 입력하세요',
          isRequired: true,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '재고를 입력해주세요';
            }
            if (int.tryParse(value) == null) {
              return '올바른 숫자를 입력해주세요';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDetailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('상세 정보', style: AppTextStyles.heading3Bold),
        const SizedBox(height: AppSpacing.space20),
        TextInput(
          controller: descriptionController,
          labelText: '간단 설명',
          hintText: '간단한 설명을 입력하세요',
          isRequired: true,
          maxLength: 200,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '설명을 입력해주세요';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.layoutPadding),
        TextInput(
          controller: detailDescriptionController,
          labelText: '상세 설명',
          hintText: '상세한 설명을 입력하세요',
          isRequired: true,
          maxLength: 1000,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '상세 설명을 입력해주세요';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이미지', style: AppTextStyles.heading3Bold),
        const SizedBox(height: AppSpacing.space20),
        SecondaryButton(
          text: '이미지 선택 (${existingImageUrls.length + selectedImages.length}개)',
          onPressed: onPickImages,
          icon: Icons.image,
        ),
        const SizedBox(height: AppSpacing.space12),
        if (existingImageUrls.isNotEmpty || selectedImages.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(AppSpacing.space12),
            decoration: BoxDecoration(
              color: AppColors.subSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이미지 미리보기',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.space8),
                Wrap(
                  spacing: AppSpacing.space8,
                  runSpacing: AppSpacing.space8,
                  children: [
                    // 기존 이미지 표시
                    ...existingImageUrls
                        .asMap()
                        .entries
                        .map(
                          (entry) => _buildExistingImagePreview(entry.key, entry.value),
                        ),
                    // 새로 선택한 이미지 표시
                    ...selectedImages
                        .asMap()
                        .entries
                        .map(
                          (entry) => _buildNewImagePreview(entry.key, entry.value),
                        ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildExistingImagePreview(int index, String imageUrl) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.image,
                    color: AppColors.textDisabled,
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemoveExistingImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewImagePreview(int index, XFile image) {
    return Stack(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primaryGreen,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: kIsWeb
                ? Image.network(
                    image.path,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image,
                          color: AppColors.textDisabled,
                        ),
                      );
                    },
                  )
                : Image.file(
                    File(image.path),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.image,
                          color: AppColors.textDisabled,
                        ),
                      );
                    },
                  ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemoveNewImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          left: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'NEW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSalesSettingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('판매 설정', style: AppTextStyles.heading3Bold),
        const SizedBox(height: AppSpacing.space20),
        Container(
          padding: const EdgeInsets.all(AppSpacing.layoutPadding),
          decoration: BoxDecoration(
            color: AppColors.subSurface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('판매 가능', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 4),
                  Text(
                    isAvailable ? '현재 판매중입니다' : '현재 판매 중지 상태입니다',
                    style: AppTextStyles.subRegular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Switch(
                value: isAvailable,
                onChanged: onAvailabilityChanged,
                activeThumbColor: AppColors.primaryGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}