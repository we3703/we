import 'package:we/domain/entities/notice/notice_entity.dart';
import 'package:we/domain/use_cases/notice/get_notice_detail_use_case.dart';
import 'package:we/domain/use_cases/notice/get_notices_use_case.dart';
import 'package:we/presentation/base/base_view_model.dart';

class NoticeViewModel extends BaseViewModel {
  final GetNoticesUseCase _getNoticesUseCase;
  final GetNoticeDetailUseCase _getNoticeDetailUseCase;

  NoticeViewModel(this._getNoticesUseCase, this._getNoticeDetailUseCase);

  List<NoticeEntity>? _notices;
  List<NoticeEntity>? get notices => _notices;

  NoticeEntity? _noticeDetail;
  NoticeEntity? get noticeDetail => _noticeDetail;

  Future<void> getNotices() async {
    setLoading(true);
    clearError();

    final result = await _getNoticesUseCase();

    result.when(
      success: (data) {
        _notices = data;
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _notices = null;
      },
    );

    setLoading(false);
  }

  Future<void> getNoticeDetail(String noticeId) async {
    setLoading(true);
    clearError();

    final result = await _getNoticeDetailUseCase(noticeId);

    result.when(
      success: (data) {
        _noticeDetail = data;
        setError(null);
      },
      failure: (failure) {
        setError(mapFailureToMessage(failure));
        _noticeDetail = null;
      },
    );

    setLoading(false);
  }
}
