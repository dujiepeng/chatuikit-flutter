import 'package:em_chat_uikit/chat_uikit.dart';

mixin ChatUIKitChatActions on ChatSDKWrapper {
  @override
  Future<int> getUnreadMessageCount({List<String>? withoutIds}) async {
    int unreadCount = 0;
    List<Conversation> list = await ChatUIKit.instance.getAllConversations();
    if (list.isEmpty) return unreadCount;
    for (var conversation in list) {
      if (withoutIds?.isNotEmpty == true) {
        if (withoutIds!.contains(conversation.id)) continue;
      }

      if (!ChatUIKitContext.instance.conversationIsMute(conversation.id)) {
        unreadCount += await conversation.unreadCount();
      }
    }
    return unreadCount;
  }
}
