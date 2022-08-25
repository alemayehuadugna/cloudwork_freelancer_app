// ignore_for_file: file_names

class Sort {
  final String field;
  final String direction;

  Sort(this.field, this.direction);
}

class Pagination {
  final int page;
  final int pageSize;

  Pagination(this.page, this.pageSize);
}

class ResultPage {
  final int current;
  final int pageSize;
  final int totalPages;
  final int totalElements;
  final bool first;
  final bool last;

  ResultPage({
    required this.current,
    required this.pageSize,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.last,
  });
}

class PaginatedQueryResult<T> {
  final T? data;
  final ResultPage page;

  PaginatedQueryResult({required this.data, required this.page});
}
