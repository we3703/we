import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/domain/entities/product/product_summary_entity.dart';
import 'package:we/presentation/atoms/buttons/primary_button.dart';
import 'package:we/presentation/atoms/buttons/secondary_button.dart';
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
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _salePriceController;
  late TextEditingController _descriptionController;
  late TextEditingController _detailDescriptionController;
  late TextEditingController _stockController;
  late bool _isAvailable;
  List<XFile> _selectedImages = [];

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
    _salePriceController = TextEditingController(
      text: widget.product?.salePrice.toString() ?? '',
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
    _isAvailable = widget.product?.isAvailable ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _salePriceController.dispose();
    _descriptionController.dispose();
    _detailDescriptionController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      setState(() {
        _selectedImages = images;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다: $e')));
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _saveProduct() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.product == null) {
        // Create new product - validate images
        if (_selectedImages.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('최소 1개 이상의 이미지를 선택해주세요.')),
          );
          return;
        }

        final request = CreateProductRequest(
          name: _nameController.text,
          category: _categoryController.text,
          price: int.tryParse(_priceController.text) ?? 0,
          salePrice: int.tryParse(_salePriceController.text) ?? 0,
          description: _descriptionController.text,
          detailDescription: _detailDescriptionController.text,
          stock: int.tryParse(_stockController.text) ?? 0,
          isAvailable: _isAvailable,
          specifications: {},
          imageFiles: _selectedImages,
        );
        context.read<AdminProductViewModel>().createProduct(request);
      } else {
        // Update existing product
        final request = UpdateProductRequest(
          name: _nameController.text,
          price: int.tryParse(_priceController.text),
          salePrice: int.tryParse(_salePriceController.text),
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
      resizeToAvoidBottomInset: true,
      appBar: AppHeader(
        title: isEdit ? '제품 수정' : '제품 생성',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: AppSpacing.layoutPadding,
          right: AppSpacing.layoutPadding,
          top: AppSpacing.layoutPadding,
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              AppSpacing.layoutPadding,
        ),
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
                controller: _salePriceController,
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

              SecondaryButton(
                text: '이미지 선택 (${_selectedImages.length}개)',
                onPressed: _pickImages,
                icon: Icons.image,
              ),
              const SizedBox(height: AppSpacing.space12),

              if (_selectedImages.isNotEmpty)
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
                        '선택된 이미지',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space8),
                      Wrap(
                        spacing: AppSpacing.space8,
                        runSpacing: AppSpacing.space8,
                        children: _selectedImages
                            .asMap()
                            .entries
                            .map(
                              (entry) => Stack(
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
                                        entry.value.path,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
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
                                      onTap: () => _removeImage(entry.key),
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
                              ),
                            )
                            .toList(),
                      ),
                    ],
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
