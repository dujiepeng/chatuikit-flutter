import 'package:em_chat_uikit/chat_uikit.dart';
import 'package:flutter/foundation.dart';

typedef ConversationListViewShowHandler = List<ConversationModel> Function(
    List<ConversationModel> conversations);

/// 会话列表控制器
class ConversationListViewController extends ChatUIKitListViewControllerBase {
  ConversationListViewController({
    this.willShowHandler,
  });

  /// 一次从服务器获取的会话列表数量，默认为 `50`。
  final int pageSize = 50;

  /// 会话列表显示前的回调，你可以在这里对会话列表进行处理，比如排序或者加减等。如果不设置将会直接显示。
  final ConversationListViewShowHandler? willShowHandler;

  String? cursor;

  /// 获取会话列表，会优先从本地获取，如果本地没有，并且没有从服务器获取过，则从服务器获取。
  ///`force` (bool) 是否强制从服务器获取，默认为 `false`。
  @override
  Future<void> fetchItemList({bool force = false}) async {
    loadingType.value = ChatUIKitListViewType.loading;
    List<Conversation> items = await ChatUIKit.instance.getAllConversations();
    try {
      if ((items.isEmpty &&
              !ChatUIKitContext.instance.isConversationLoadFinished()) ||
          force == true) {
        await fetchConversations();
        items = await ChatUIKit.instance.getAllConversations();
      }
      items = await _clearEmpty(items);
      List<ConversationModel> tmp = await _mappers(items);
      list.clear();
      list.addAll(tmp);
      list = willShowHandler?.call(list.cast<ConversationModel>()) ?? list;
      if (list.isEmpty) {
        loadingType.value = ChatUIKitListViewType.empty;
      } else {
        loadingType.value = ChatUIKitListViewType.normal;
      }
    } catch (e) {
      debugPrintStack();
      loadingType.value = ChatUIKitListViewType.error;
    }
  }

  /// 从新从本地获取会话列表
  @override
  Future<void> reload() async {
    loadingType.value = ChatUIKitListViewType.refresh;
    List<Conversation> items = await ChatUIKit.instance.getAllConversations();
    items = await _clearEmpty(items);
    List<ConversationModel> tmp = await _mappers(items);
    list.clear();
    list.addAll(tmp);
    list = willShowHandler?.call(list.cast<ConversationModel>()) ?? list;
    if (list.isEmpty) {
      loadingType.value = ChatUIKitListViewType.empty;
    } else {
      loadingType.value = ChatUIKitListViewType.normal;
    }
  }

  // @override
  // Future<List<ChatUIKitListItemModelBase>> fetchMoreItemList() async {
  //   List<ChatUIKitListItemModelBase> list = [];
  //   return list;
  // }

  Future<List<Conversation>> _clearEmpty(List<Conversation> list) async {
    List<Conversation> tmp = [];
    for (var item in list) {
      final latest = await item.latestMessage();
      if (latest != null) {
        tmp.add(item);
      }
    }
    return tmp;
  }

  bool hasFetchPinned = false;
  Future<List<Conversation>> fetchConversations() async {
    List<Conversation> items = [];
    if (!hasFetchPinned) {
      CursorResult<Conversation> result =
          await ChatUIKit.instance.fetchPinnedConversations(
        pageSize: 50,
      );
      items.addAll(result.data);
      hasFetchPinned = true;
    }
    try {
      CursorResult<Conversation> result =
          await ChatUIKit.instance.fetchConversations(
        pageSize: pageSize,
        cursor: cursor,
      );
      cursor = result.cursor;
      items.addAll(result.data);
      if (result.data.length < pageSize) {
        ChatUIKitContext.instance.setConversationLoadFinished();
        hasMore = false;
      }
      // ignore: empty_catches
    } catch (e) {}

    await _updateMuteType(items);

    if (hasMore) {
      List<Conversation> tmp = await fetchConversations();
      items.addAll(tmp);
    }
    return items;
  }

  Future<void> _updateMuteType(List<Conversation> items) async {
    try {
      await ChatUIKit.instance.fetchSilentModel(conversations: items);

      // ignore: empty_catches
    } catch (e) {}
  }

  Future<List<ConversationModel>> _mappers(
      List<Conversation> conversations) async {
    List<ChatUIKitProfile> tmp = () {
      List<ChatUIKitProfile> ret = [];
      for (var item in conversations) {
        if (item.type == ConversationType.GroupChat) {
          ret.add(ChatUIKitProfile.group(id: item.id));
        } else if (item.type == ConversationType.Chat) {
          ret.add(ChatUIKitProfile.contact(id: item.id));
        }
      }
      return ret;
    }();

    Map<String, ChatUIKitProfile> profilesMap =
        ChatUIKitProvider.instance.getProfiles(tmp);
    List<ConversationModel> list = [];
    for (var item in conversations) {
      ConversationModel info = await ConversationModel.fromConversation(
        item,
        profilesMap[item.id]!,
      );
      list.add(info);
    }
    return list;
  }
}
