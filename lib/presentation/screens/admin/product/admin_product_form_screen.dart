import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we/data/models/product/create_product_request.dart';
import 'package:we/data/models/product/update_product_request.dart';
import 'package:we/domain/entities/product/product_summary_entity.dart';
import 'package:we/presentation/foundations/spacing.dart';
import 'package:we/presentation/molecules/appbar/app_header.dart';
import 'package:we/presentation/organisms/product/product_form.dart';
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
  List<String> _existingImageUrls = [];
  final List<XFile> _selectedImages = [];

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
    _existingImageUrls = widget.product?.images ?? [];
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
        _selectedImages.addAll(images);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다: $e')));
      }
    }
  }

  void _removeExistingImage(int index) {
    setState(() {
      _existingImageUrls.removeAt(index);
    });
  }

  void _removeNewImage(int index) {
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
          existingImageUrls: _existingImageUrls,
          newImageFiles: _selectedImages,
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
        child: ProductForm(
          formKey: _formKey,
          nameController: _nameController,
          categoryController: _categoryController,
          priceController: _priceController,
          salePriceController: _salePriceController,
          descriptionController: _descriptionController,
          detailDescriptionController: _detailDescriptionController,
          stockController: _stockController,
          isAvailable: _isAvailable,
          existingImageUrls: _existingImageUrls,
          selectedImages: _selectedImages,
          onPickImages: _pickImages,
          onRemoveExistingImage: _removeExistingImage,
          onRemoveNewImage: _removeNewImage,
          onAvailabilityChanged: (value) {
            setState(() {
              _isAvailable = value;
            });
          },
          onSave: _saveProduct,
          isEdit: isEdit,
        ),
      ),
    );
  }
}
