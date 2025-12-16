import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class CreateProductRequest {
  final String name;
  final String category;
  final int price;
  final int salePrice;
  final String description;
  final String detailDescription;
  final int stock;
  final bool isAvailable;
  final Map<String, dynamic> specifications;
  final List<XFile> imageFiles; // Changed from List<String> to List<XFile>

  CreateProductRequest({
    required this.name,
    required this.category,
    required this.price,
    required this.salePrice,
    required this.description,
    required this.detailDescription,
    required this.stock,
    required this.isAvailable,
    required this.specifications,
    required this.imageFiles,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'sale_price': salePrice,
      'description': description,
      'detail_description': detailDescription,
      'stock': stock,
      'is_available': isAvailable,
      'specifications': specifications,
    };
  }

  /// Convert to multipart/form-data fields and files
  /// Server expects: product_in (JSON string) and images (array of files)
  Map<String, String> getMultipartFields() {
    final fields = <String, String>{};

    // product_in: JSON string containing all fields except images
    final productIn = {
      'name': name,
      'category': category,
      'price': price,
      'sale_price': salePrice,
      'description': description,
      'detail_description': detailDescription,
      'stock': stock,
      'is_available': isAvailable,
      'specifications': specifications,
    };
    fields['product_in'] = jsonEncode(productIn);

    return fields;
  }

  /// Convert image files to MultipartFile list
  Future<List<http.MultipartFile>> getMultipartFiles() async {
    final files = <http.MultipartFile>[];

    for (int i = 0; i < imageFiles.length; i++) {
      final file = imageFiles[i];
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
        'images', // Field name for all images
        bytes,
        filename: file.name,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );

      files.add(multipartFile);
    }

    return files;
  }
}
