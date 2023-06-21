import '../../common/constants.dart';

class Pagination {
  int limit;
  int page;
  int total;

  Pagination({
    this.limit = PaginationConstant.lowLimit,
    this.page = 1,
    this.total = 0,
  });

  bool get canNext {
    return total == limit * (page - 1);
  }

  int get currentPage => total ~/ limit;

  int get nextPage => page + 1;

  int get size => limit;

  void setTotal(List<dynamic>? list) {
    total = list?.length ?? 0;
  }

  @override
  String toString() {
    return '{"limit": $limit, "page": $page, "total": $total}';
  }
}
