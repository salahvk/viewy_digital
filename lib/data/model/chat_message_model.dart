class Chat {
  final String profileImage;
  final String name;
  final String subtitle;
  final String lastMessage;
  final bool hasUnreadMessages;
  final bool isMessageSent;
  final bool isMessageDelivered;

  Chat({
    required this.profileImage,
    required this.name,
    required this.subtitle,
    required this.lastMessage,
    this.hasUnreadMessages = false,
    this.isMessageSent = false,
    this.isMessageDelivered = false,
  });
}
