/// 숫자를 천 단위 콤마로 포맷팅합니다.
///
/// 예시:
/// - formatNumber(10000) → "10,000"
/// - formatNumber(1234567) → "1,234,567"
/// - formatNumber(0) → "0"
String formatNumber(int number) {
  return number.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (Match m) => '${m[1]},',
  );
}
