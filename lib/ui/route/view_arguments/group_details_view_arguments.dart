import 'package:em_chat_uikit/chat_uikit.dart';
import 'package:flutter/widgets.dart';

class GroupDetailsViewArguments implements ChatUIKitViewArguments {
  GroupDetailsViewArguments({
    required this.profile,
    required this.actions,
    this.appBar,
    this.enableAppBar = true,
    this.onMessageDidClear,
    this.viewObserver,
    this.contentWidgetBuilder,
    this.attributes,
  });
  final ChatUIKitProfile profile;
  final List<ChatUIKitModelAction> actions;
  final ChatUIKitAppBar? appBar;
  final bool enableAppBar;
  final VoidCallback? onMessageDidClear;
  final WidgetBuilder? contentWidgetBuilder;

  @override
  String? attributes;
  @override
  ChatUIKitViewObserver? viewObserver;

  GroupDetailsViewArguments copyWith({
    ChatUIKitProfile? profile,
    List<ChatUIKitModelAction>? actions,
    bool? enableAppBar,
    ChatUIKitAppBar? appBar,
    WidgetBuilder? contentWidgetBuilder,
    ChatUIKitViewObserver? viewObserver,
    VoidCallback? onMessageDidClear,
    String? attributes,
  }) {
    return GroupDetailsViewArguments(
      profile: profile ?? this.profile,
      actions: actions ?? this.actions,
      enableAppBar: enableAppBar ?? this.enableAppBar,
      appBar: appBar ?? this.appBar,
      onMessageDidClear: onMessageDidClear ?? this.onMessageDidClear,
      viewObserver: viewObserver ?? this.viewObserver,
      contentWidgetBuilder: contentWidgetBuilder ?? this.contentWidgetBuilder,
      attributes: attributes ?? this.attributes,
    );
  }
}
