import 'package:em_chat_uikit/chat_uikit.dart';
import 'package:flutter/services.dart';

class ContactDetailsViewArguments implements ChatUIKitViewArguments {
  ContactDetailsViewArguments({
    required this.profile,
    required this.actions,
    this.onMessageDidClear,
    this.enableAppBar = true,
    this.appBar,
    this.viewObserver,
    this.attributes,
  });

  final ChatUIKitProfile profile;
  final List<ChatUIKitModelAction> actions;
  final VoidCallback? onMessageDidClear;
  final bool enableAppBar;
  final ChatUIKitAppBar? appBar;
  @override
  String? attributes;
  @override
  ChatUIKitViewObserver? viewObserver;

  ContactDetailsViewArguments copyWith({
    ChatUIKitProfile? profile,
    List<ChatUIKitModelAction>? actions,
    VoidCallback? onMessageDidClear,
    bool? enableAppBar,
    ChatUIKitAppBar? appBar,
    ChatUIKitViewObserver? viewObserver,
    String? attributes,
  }) {
    return ContactDetailsViewArguments(
      profile: profile ?? this.profile,
      actions: actions ?? this.actions,
      onMessageDidClear: onMessageDidClear ?? this.onMessageDidClear,
      enableAppBar: enableAppBar ?? this.enableAppBar,
      appBar: appBar ?? this.appBar,
      viewObserver: viewObserver ?? this.viewObserver,
      attributes: attributes ?? this.attributes,
    );
  }
}
