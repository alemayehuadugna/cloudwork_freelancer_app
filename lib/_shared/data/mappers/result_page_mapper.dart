import '../../../_core/cqrs.dart';
import '../models/json/result_page_remote_model.dart';

class ResultPageMapper {
  static ResultPage fromJson(Map<String, dynamic> json) {
    final resultPage = ResultPageRemoteModel.fromJson(json);
    return ResultPage(
      current: resultPage.current,
      pageSize: resultPage.pageSize,
      totalPages: resultPage.totalPages,
      totalElements: resultPage.totalElements,
      first: resultPage.first,
      last: resultPage.last,
    );
  }
}
