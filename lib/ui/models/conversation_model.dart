import 'package:em_chat_uikit/chat_uikit.dart';

import '../../universal/defines.dart';

class ConversationModel with ChatUIKitListItemModelBase, NeedSearch {
  final Message? lastMessage;
  final int unreadCount;
  final bool pinned;
  final bool noDisturb;
  final bool hasMention;
  final String? attribute;
  @override
  ChatUIKitProfile profile;

  ConversationModel({
    required this.profile,
    this.lastMessage,
    this.unreadCount = 0,
    this.noDisturb = false,
    this.pinned = false,
    this.hasMention = false,
    this.attribute,
  });

  static Future<ConversationModel> fromConversation(
    Conversation conversation,
    ChatUIKitProfile profile,
  ) async {
    int unreadCount = await conversation.unreadCount();
    Message? lastMessage = await conversation.latestMessage();

    bool noDisturb =
        ChatUIKitContext.instance.conversationIsMute(conversation.id);

    ConversationModel info = ConversationModel(
      profile: profile,
      unreadCount: unreadCount,
      lastMessage: lastMessage,
      pinned: conversation.isPinned,
      noDisturb: noDisturb,
      hasMention: conversation.ext?[hasMentionKey] == hasMentionValue,
    );
    return info;
  }

  ConversationModel copyWith({
    Message? lastMessage,
    int? unreadCount,
    bool? pinned,
    bool? noDisturb,
    bool? hasMention,
    String? attribute,
  }) {
    return ConversationModel(
      profile: profile,
      lastMessage: lastMessage ?? this.lastMessage,
      unreadCount: unreadCount ?? this.unreadCount,
      pinned: pinned ?? this.pinned,
      noDisturb: noDisturb ?? this.noDisturb,
      hasMention: hasMention ?? this.hasMention,
      attribute: attribute ?? this.attribute,
    );
  }

  @override
  String get showName {
    return profile.showName;
  }

  String? get avatarUrl {
    return profile.avatarUrl;
  }
}
