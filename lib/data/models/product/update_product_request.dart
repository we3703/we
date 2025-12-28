import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UpdateProductRequest {
  final String? name;
  final int? price;
  final int? salePrice;
  final int? stock;
  final bool? isAvailable;
  final List<String>? existingImageUrls;
  final List<XFile>? newImageFiles;

  UpdateProductRequest({
    this.name,
    this.price,
    this.salePrice,
    this.stock,
    this.isAvailable,
    this.existingImageUrls,
    this.newImageFiles,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> productData = {};
    if (name != null) productData['name'] = name;
    if (price != null) productData['price'] = price;
    if (salePrice != null) productData['sale_price'] = salePrice;
    if (stock != null) productData['stock'] = stock;
    if (isAvailable != null) productData['isAvailable'] = isAvailable;

    return productData;
  }

  /// Convert to multipart/form-data fields
  /// Server expects: product_in (JSON string with existing images) and images (new files only)
  Map<String, String> getMultipartFields() {
    final fields = <String, String>{};

    // product_in: JSON string containing all update fields including existing image URLs
    final productData = toJson();

    // 기존 이미지 URL들을 product_in에 포함
    if (existingImageUrls != null && existingImageUrls!.isNotEmpty) {
      productData['images'] = existingImageUrls;
    }

    fields['product_in'] = jsonEncode(productData);

    return fields;
  }

  /// Convert new image files to MultipartFile list
  Future<List<http.MultipartFile>> getMultipartFiles() async {
    final files = <http.MultipartFile>[];

    if (newImageFiles != null) {
      for (int i = 0; i < newImageFiles!.length; i++) {
        final file = newImageFiles![i];
        final bytes = await file.readAsBytes();

        // Determine content type based on file extension
        String? mimeType;
        if (file.name.endsWith('.jpg') || file.name.endsWith('.jpeg')) {
          mimeType = 'image/jpeg';
        } else if (file.name.endsWith('.png')) {
          mimeType = 'image/png';
        } else if (file.name.endsWith('.gif')) {
          mimeType = 'image/gif';
        } else if (file.name.endsWith('.webp')) {
          mimeType = 'image/webp';
        }

        final multipartFile = http.MultipartFile.fromBytes(
          'images',
          bytes,
          filename: file.name,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        );

        files.add(multipartFile);
      }
    }

    return files;
  }
}
