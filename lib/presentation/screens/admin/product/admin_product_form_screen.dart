import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/domain/entities/product/product_summary_entity.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/inputs/text_input.dart';
import 'package:we/presentation/foundations/colors.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/foundations/typography.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/screens/admin/product/admin_product_view_model.dart';

class AdminProductFormScreen extends StatefulWidget {
  static const routeName = '/admin/product/form';
  final ProductSummaryEntity? product;

  const AdminProductFormScreen({super.key, this.product});

  @override
  State<AdminProductFormScreen> createState() => _AdminProductFormScreenState();
}

class _AdminProductFormScreenState extends State<AdminProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _detailDescriptionController;
  late TextEditingController _stockController;
  late TextEditingController _imagesController;
  late bool _isAvailable;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _categoryController = TextEditingController(
      text: widget.product?.category ?? '',
    );
    _priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    _detailDescriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    _stockController = TextEditingController(
      text: widget.product?.stock.toString() ?? '',
    );
    _imagesController = TextEditingController(
      text: widget.product?.images.join(', ') ?? '',
    );
    _isAvailable = widget.product?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _detailDescriptionController.dispose();
    _stockController.dispose();
    _imagesController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.product == null) {
        // Create new product
        final request = CreateProductRequest(
          name: _nameController.text,
          category: _categoryController.text,
          price: int.tryParse(_priceController.text) ?? 0,
          description: _descriptionController.text,
          detailDescription: _detailDescriptionController.text,
          stock: int.tryParse(_stockController.text) ?? 0,
          isAvailable: _isAvailable,
          specifications: {},
          images: _imagesController.text
              .split(',')
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList(),
        );
        context.read<AdminProductViewModel>().createProduct(request);
      } else {
        // Update existing product
        final request = UpdateProductRequest(
          name: _nameController.text,
          price: int.tryParse(_priceController.text),
          stock: int.tryParse(_stockController.text),
          isAvailable: _isAvailable,
        );
        context.read<AdminProductViewModel>().updateProduct(
          widget.product!.productId,
          request,
        );
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppHeader(
        title: isEdit ? '제품 수정' : '제품 생성',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.layoutPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('기본 정보', style: AppTextStyles.heading3Bold),
              const SizedBox(height: AppSpacing.space20),

              TextInput(
                controller: _nameController,
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
                controller: _categoryController,
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
                controller: _priceController,
                labelText: '가격',
                hintText: '가격을 입력하세요',
                isRequired: true,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '가격을 입력해주세요';
                  }
                  if (int.tryParse(value) == null) {
                    return '올바른 숫자를 입력해주세요';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.layoutPadding),

              TextInput(
                controller: _stockController,
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
              const SizedBox(height: AppSpacing.space20),

              const Divider(),
              const SizedBox(height: AppSpacing.space20),

              Text('상세 정보', style: AppTextStyles.heading3Bold),
              const SizedBox(height: AppSpacing.space20),

              TextInput(
                controller: _descriptionController,
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
                controller: _detailDescriptionController,
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
              const SizedBox(height: AppSpacing.space20),

              const Divider(),
              const SizedBox(height: AppSpacing.space20),

              Text('이미지', style: AppTextStyles.heading3Bold),
              const SizedBox(height: AppSpacing.space20),

              TextInput(
                controller: _imagesController,
                labelText: '이미지 URL',
                hintText: 'URL을 쉼표(,)로 구분하여 입력하세요',
              ),
              const SizedBox(height: AppSpacing.space8),
              Text(
                '여러 이미지는 쉼표(,)로 구분하여 입력하세요',
                style: AppTextStyles.subRegular.copyWith(
                  color: AppColors.textDisabled,
                ),
              ),
              const SizedBox(height: AppSpacing.space20),

              const Divider(),
              const SizedBox(height: AppSpacing.space20),

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
                          _isAvailable ? '현재 판매중입니다' : '현재 판매 중지 상태입니다',
                          style: AppTextStyles.subRegular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _isAvailable,
                      onChanged: (value) {
                        setState(() {
                          _isAvailable = value;
                        });
                      },
                      activeThumbColor: AppColors.primaryGreen,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.space32),

              PrimaryButton(
                text: isEdit ? '수정하기' : '생성하기',
                onPressed: _saveProduct,
              ),
              const SizedBox(height: AppSpacing.space20),
            ],
          ),
        ),
      ),
    );
  }
}
