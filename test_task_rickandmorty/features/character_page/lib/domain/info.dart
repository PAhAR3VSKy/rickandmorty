/// Сущность информации
class Info {
  /// Количество
  final int count;

  /// Страницы
  final int pages;

  /// Следующая страница
  final String next;

  /// Предыдущая страница
  final String prev;

  /// Конструктор [Info]
  Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });
}
