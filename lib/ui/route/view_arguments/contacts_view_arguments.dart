import 'package:em_chat_uikit/chat_uikit.dart';
import 'package:flutter/widgets.dart';

class ContactsViewArguments implements ChatUIKitViewArguments {
  ContactsViewArguments({
    this.controller,
    this.appBar,
    this.enableAppBar = true,
    this.enableSearchBar = true,
    this.onSearchTap,
    this.listViewItemBuilder,
    this.onTap,
    this.onLongPress,
    this.searchHideText,
    this.listViewBackground,
    this.loadErrorMessage,
    this.beforeItems,
    this.afterItems,
    this.title,
    this.attributes,
  });

  /// 联系人列表控制器，用于控制联系人列表数据，如果不设置将会自动创建。详细参考 [ContactListViewController]。
  final ContactListViewController? controller;

  /// 自定义AppBar, 如果设置后将会替换默认的AppBar。详细参考 [ChatUIKitAppBar]。
  final ChatUIKitAppBar? appBar;

  /// 是否显示AppBar, 默认为 `true`。 当为 `false` 时将不会显示AppBar。同时也会影响到是否显示标题。
  final bool enableAppBar;

  /// 自定义标题。
  final String? title;

  /// 点击搜索按钮的回调，点击后会把当前的联系人列表数据传递过来。如果不设置默认会跳转到搜索页面。具体参考 [SearchView]。
  final void Function(List<ContactItemModel> data)? onSearchTap;

  /// 是否开启搜索框，默认为 `true`。如果设置为 `false` 将不会显示搜索框。
  final bool enableSearchBar;

  /// 联系人列表之前的数据。
  final List<ChatUIKitListViewMoreItem>? beforeItems;

  /// 联系人列表之后的数据。
  final List<ChatUIKitListViewMoreItem>? afterItems;

  /// 联系人列表的 `item` 构建器，如果设置后需要显示联系人时会直接回调，如果不处理可以返回 `null`。
  final ChatUIKitContactItemBuilder? listViewItemBuilder;

  /// 点击联系人列表的回调，点击后会把当前的联系人数据传递过来。具体参考 [ContactItemModel]。 如果不是设置默认会跳转到联系人详情页面。具体参考 [ContactDetailsView]。
  final void Function(BuildContext context, ContactItemModel model)? onTap;

  /// 长按联系人列表的回调，长按后会把当前的联系人数据传递过来。具体参考 [ContactItemModel]。
  final void Function(BuildContext context, ContactItemModel model)?
      onLongPress;

  /// 联系人搜索框的隐藏文字。
  final String? searchHideText;

  /// 联系人列表的背景，联系人为空时会显示，如果设置后将会替换默认的背景。
  final Widget? listViewBackground;

  /// 联系人列表的加载错误提示，如果设置后将会替换默认的错误提示。
  final String? loadErrorMessage;

  /// View 附加属性，设置后的内容将会带入到下一个页面。
  @override
  String? attributes;

  ContactsViewArguments copyWith({
    ContactListViewController? controller,
    ChatUIKitAppBar? appBar,
    void Function(List<ContactItemModel> data)? onSearchTap,
    ChatUIKitContactItemBuilder? listViewItemBuilder,
    void Function(BuildContext context, ContactItemModel model)? onTap,
    void Function(BuildContext context, ContactItemModel model)? onLongPress,
    String? searchHideText,
    Widget? listViewBackground,
    String? loadErrorMessage,
    bool? enableSearchBar,
    bool? enableAppBar,
    String? attributes,
  }) {
    return ContactsViewArguments(
      controller: controller ?? this.controller,
      appBar: appBar ?? this.appBar,
      enableSearchBar: enableSearchBar ?? this.enableSearchBar,
      onSearchTap: onSearchTap ?? this.onSearchTap,
      listViewItemBuilder: listViewItemBuilder ?? this.listViewItemBuilder,
      onTap: onTap ?? this.onTap,
      onLongPress: onLongPress ?? this.onLongPress,
      searchHideText: searchHideText ?? this.searchHideText,
      listViewBackground: listViewBackground ?? this.listViewBackground,
      loadErrorMessage: loadErrorMessage ?? this.loadErrorMessage,
      enableAppBar: enableAppBar ?? this.enableAppBar,
      attributes: attributes ?? this.attributes,
    );
  }
}
