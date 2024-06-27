import 'package:em_chat_uikit/chat_uikit.dart';

import 'package:flutter/widgets.dart';

class ContactDetailsViewArguments implements ChatUIKitViewArguments {
  ContactDetailsViewArguments({
    required this.profile,
    this.actionsBuilder,
    this.onMessageDidClear,
    this.appBarModel,
    this.viewObserver,
    this.detailsListViewItemsBuilder,
    this.attributes,
    this.onContactDeleted,
    this.enableAppBar = true,
    this.moreActionsBuilder,
  });

  final ChatUIKitProfile profile;
  final ChatUIKitDetailContentActionsBuilder? actionsBuilder;
  final VoidCallback? onMessageDidClear;
  final ChatUIKitAppBarModel? appBarModel;
  final ChatUIKitDetailItemBuilder? detailsListViewItemsBuilder;
  final VoidCallback? onContactDeleted;
  @override
  String? attributes;
  @override
  ChatUIKitViewObserver? viewObserver;
  final ChatUIKitMoreActionsBuilder<bool>? moreActionsBuilder;
  final bool enableAppBar;

  ContactDetailsViewArguments copyWith({
    ChatUIKitProfile? profile,
    ChatUIKitDetailContentActionsBuilder? actionsBuilder,
    VoidCallback? onMessageDidClear,
    ChatUIKitAppBarModel? appBarModel,
    ChatUIKitViewObserver? viewObserver,
    VoidCallback? onContactDeleted,
    String? attributes,
    ChatUIKitDetailItemBuilder? detailsListViewItemsBuilder,
    ChatUIKitMoreActionsBuilder<bool>? moreActionsBuilder,
    bool? enableAppBar,
  }) {
    return ContactDetailsViewArguments(
      profile: profile ?? this.profile,
      actionsBuilder: actionsBuilder ?? this.actionsBuilder,
      onMessageDidClear: onMessageDidClear ?? this.onMessageDidClear,
      appBarModel: appBarModel ?? this.appBarModel,
      viewObserver: viewObserver ?? this.viewObserver,
      attributes: attributes ?? this.attributes,
      detailsListViewItemsBuilder:
          detailsListViewItemsBuilder ?? this.detailsListViewItemsBuilder,
      moreActionsBuilder: moreActionsBuilder ?? this.moreActionsBuilder,
      enableAppBar: enableAppBar ?? this.enableAppBar,
      onContactDeleted: onContactDeleted ?? this.onContactDeleted,
    );
  }
}
