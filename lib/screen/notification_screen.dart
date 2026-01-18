import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _items = [
    NotificationItem(
      type: NotificationType.message,
      title: 'New message',
      message: 'Makara sent you a message.',
      time: '2m',
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.order,
      title: 'Order confirmed',
      message: 'Your order #1024 has been confirmed.',
      time: '1h',
      isRead: true,
    ),
    NotificationItem(
      type: NotificationType.security,
      title: 'Security alert',
      message: 'Your password was changed successfully.',
      time: 'Yesterday',
      isRead: true,
    ),
    NotificationItem(
      type: NotificationType.promo,
      title: 'Special offer',
      message: 'Get 20% off today only.',
      time: '2d',
      isRead: false,
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (final n in _items) {
        n.isRead = true;
      }
    });
  }

  void _openNotification(NotificationItem item) {
    setState(() => item.isRead = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(item.title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: const Text('Mark all'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _items.isEmpty
          ? const _EmptyState()
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _items[index];
          final meta = item.meta;

          return Dismissible(
            key: ValueKey('${item.title}-$index'),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete),
            ),
            onDismissed: (_) =>
                setState(() => _items.removeAt(index)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _openNotification(item),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceVariant,
                          ),
                          child: Icon(meta.icon),
                        ),
                        if (!item.isRead)
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: item.isRead
                                        ? FontWeight.w600
                                        : FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.time,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item.message,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceVariant,
                                ),
                                child: Text(
                                  meta.label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium,
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.chevron_right),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.notifications_none, size: 64),
            SizedBox(height: 12),
            Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text('You’re all caught up for now.'),
          ],
        ),
      ),
    );
  }
}

enum NotificationType { message, order, security, promo }

class NotificationItem {
  final NotificationType type;
  final String title;
  final String message;
  final String time;
  bool isRead;

  NotificationItem({
    required this.type,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });

  NotificationMeta get meta {
    switch (type) {
      case NotificationType.message:
        return const NotificationMeta(
          label: 'Message',
          icon: Icons.chat_bubble_outline,
        );
      case NotificationType.order:
        return const NotificationMeta(
          label: 'Order',
          icon: Icons.shopping_bag_outlined,
        );
      case NotificationType.security:
        return const NotificationMeta(
          label: 'Security',
          icon: Icons.verified_user_outlined,
        );
      case NotificationType.promo:
        return const NotificationMeta(
          label: 'Promo',
          icon: Icons.local_offer_outlined,
        );
    }
  }
}

class NotificationMeta {
  final String label;
  final IconData icon;

  const NotificationMeta({
    required this.label,
    required this.icon,
  });
}
