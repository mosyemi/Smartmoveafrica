class NotificationItem {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });
}

class NotificationService {
  Future<List<NotificationItem>> fetchMockNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 180));
    return [
      NotificationItem(
        id: 'ntf-1',
        title: 'Traffic alert',
        body: 'Heavy congestion detected near Nyayo Stadium.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      NotificationItem(
        id: 'ntf-2',
        title: 'Transport update',
        body: 'CBD -> Rongai vehicles are running on schedule.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 17)),
      ),
    ];
  }
}
