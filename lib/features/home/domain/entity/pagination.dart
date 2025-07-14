class Pagination {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;
  const Pagination({required this.totalCount, required this.perPage, required this.maxPage, required this.currentPage});

  bool get isLastPage => currentPage == maxPage;
}
