import 'package:em_chat_uikit/provider/chat_uikit_profile.dart';
import 'package:flutter/widgets.dart';

abstract mixin class ChatUIKitListItemModelBase {
  String get showName;
}

mixin NeedSearch on ChatUIKitListItemModelBase {
  ChatUIKitProfile get profile;
}

mixin NeedAlphabetical on ChatUIKitListItemModelBase {
  double get itemHeight;
  String get firstLetter {
    if (showName.isEmpty) return '#';
    return showName.substring(0, 1);
  }
}

mixin NeedAlphabeticalWidget implements Widget {
  double get itemHeight;
}
