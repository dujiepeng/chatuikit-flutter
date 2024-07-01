import '../chat_sdk_wrapper.dart';

abstract mixin class ThreadObserver implements ChatUIKitObserverBase {
  void onChatThreadCreate(ChatThreadEvent event) {}
  void onChatThreadDestroy(ChatThreadEvent event) {}
  void onChatThreadUpdate(ChatThreadEvent event) {}
  void onUserKickOutOfChatThread(ChatThreadEvent event) {}
}
