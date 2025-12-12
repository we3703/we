import 'package:flutter/material.dart';
import 'package:we/core/error/failure.dart';
import 'package:we/data/models/admin/notice/upsert_notice_request.dart';
import 'package:we/domain/entities/common/delete_response_entity.dart';
import 'package:we/domain/entities/notice/notice_entity.dart';
import 'package:we/domain/use_cases/admin/notice/create_admin_notice_use_case.dart';
import 'package:we/domain/use_cases/admin/notice/delete_admin_notice_use_case.dart';
import 'package:we/domain/use_cases/admin/notice/update_admin_notice_use_case.dart';
import 'package:we/domain/use_cases/notice/get_notice_detail_use_case.dart';
import 'package:we/domain/use_cases/notice/get_notices_use_case.dart';

class AdminNoticeViewModel extends ChangeNotifier {
  final CreateAdminNoticeUseCase _createAdminNoticeUseCase;
  final UpdateAdminNoticeUseCase _updateAdminNoticeUseCase;
  final DeleteAdminNoticeUseCase _deleteAdminNoticeUseCase;
  final GetNoticesUseCase _getNoticesUseCase;
  final GetNoticeDetailUseCase _getNoticeDetailUseCase;

  AdminNoticeViewModel(
    this._createAdminNoticeUseCase,
    this._updateAdminNoticeUseCase,
    this._deleteAdminNoticeUseCase,
    this._getNoticesUseCase,
    this._getNoticeDetailUseCase,
  );

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<NoticeEntity>? _notices;
  List<NoticeEntity>? get notices => _notices;

  NoticeEntity? _noticeDetail;
  NoticeEntity? get noticeDetail => _noticeDetail;

  DeleteResponseEntity? _deleteResponse;
  DeleteResponseEntity? get deleteResponse => _deleteResponse;

  Future<void> getNotices() async {
    _isLoading = true;
    notifyListeners();

    final result = await _getNoticesUseCase();

    result.when(
      success: (data) {
        _notices = data;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _notices = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getNoticeDetail(String noticeId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _getNoticeDetailUseCase(noticeId);

    result.when(
      success: (data) {
        _noticeDetail = data;
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _noticeDetail = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> createAdminNotice(UpsertNoticeRequest request) async {
    _isLoading = true;
    notifyListeners();

    final result = await _createAdminNoticeUseCase(request);

    result.when(
      success: (_) {
        getNotices(); // Refresh list
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateAdminNotice(
    String noticeId,
    UpsertNoticeRequest request,
  ) async {
    _isLoading = true;
    notifyListeners();

    final result = await _updateAdminNoticeUseCase(noticeId, request);

    result.when(
      success: (_) {
        getNotices(); // Refresh list
        getNoticeDetail(noticeId); // Refresh detail
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteAdminNotice(String noticeId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _deleteAdminNoticeUseCase(noticeId);

    result.when(
      success: (data) {
        _deleteResponse = data;
        getNotices(); // Refresh list
      },
      failure: (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _deleteResponse = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  String _mapFailureToMessage(Failure failure) {
    // Implement more specific error mapping based on your Failure types
    return failure.message;
  }
}
