// ignore_for_file: deprecated_member_use
import 'package:em_chat_uikit/chat_uikit.dart';
import 'package:flutter/material.dart';

const double borderHeight = 0.5;

enum ChatUIKitListViewType { loading, empty, error, normal, refresh }

typedef ListViewBuilder = Widget Function(
  BuildContext context,
  List<ChatUIKitListItemModelBase> list,
);

typedef ChatUIKitListItemBuilder = Widget? Function(
    BuildContext context, ChatUIKitListItemModelBase model);

class ChatUIKitListView extends StatefulWidget {
  const ChatUIKitListView({
    required this.itemBuilder,
    required this.list,
    required this.type,
    this.hasMore = true,
    this.loadMore,
    this.refresh,
    this.onSearchTap,
    this.searchBarHideText,
    this.enableSearchBar = true,
    this.background,
    this.errorMessage,
    this.reloadMessage,
    this.scrollController,
    this.beforeWidgets,
    this.afterWidgets,
    this.findChildIndexCallback,
    super.key,
  });

  final ScrollController? scrollController;
  final bool hasMore;
  final String? errorMessage;
  final String? reloadMessage;
  final ChatUIKitListViewType type;
  final VoidCallback? loadMore;
  final VoidCallback? refresh;
  final Widget? background;
  final void Function(List<ChatUIKitListItemModelBase> data)? onSearchTap;
  final bool enableSearchBar;
  final String? searchBarHideText;
  final List<ChatUIKitListItemModelBase> list;
  final ChatUIKitListItemBuilder itemBuilder;
  final List<Widget>? beforeWidgets;
  final List<Widget>? afterWidgets;
  final int? Function(Key key)? findChildIndexCallback;

  @override
  State<ChatUIKitListView> createState() => _ChatUIKitListViewState();
}

class _ChatUIKitListViewState extends State<ChatUIKitListView> {
  ScrollController? controller;

  bool hasError = false;
  bool firstLoad = true;
  @override
  void initState() {
    super.initState();
    controller =
        widget.scrollController ?? ScrollController(keepScrollOffset: true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ChatUIKitTheme.of(context);

    Widget? sliverView;

    if (widget.type == ChatUIKitListViewType.loading) {
      sliverView = Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: theme.color.isDark
                ? theme.color.neutralColor4
                : theme.color.neutralColor7,
          ),
        ),
      );
    }

    if (widget.type == ChatUIKitListViewType.empty) {
      sliverView = Center(
        child: widget.background ?? ChatUIKitImageLoader.listEmpty(),
      );
    }

    if (widget.type == ChatUIKitListViewType.error) {
      sliverView = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.background ?? ChatUIKitImageLoader.listEmpty(),
            const SizedBox(height: 8),
            Text(
              widget.errorMessage ??
                  ChatUIKitLocal.listViewLoadFailed.getString(context),
              textScaleFactor: 1.0,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: theme.color.isDark
                    ? theme.color.neutralColor7
                    : theme.color.neutralColor4,
                fontWeight: theme.font.bodyMedium.fontWeight,
                fontSize: theme.font.bodyMedium.fontSize,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                widget.refresh?.call();
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: theme.color.isDark
                      ? theme.color.primaryColor6
                      : theme.color.primaryColor5,
                ),
                child: Text(
                  widget.reloadMessage ??
                      ChatUIKitLocal.listViewReload.getString(context),
                  textScaleFactor: 1.0,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.color.isDark
                        ? theme.color.neutralColor98
                        : theme.color.neutralColor98,
                    fontWeight: theme.font.labelMedium.fontWeight,
                    fontSize: theme.font.labelMedium.fontSize,
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    if (sliverView != null) {
      sliverView = SliverFillRemaining(
        hasScrollBody: false,
        child: sliverView,
      );
    }

    Widget content = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller,
      slivers: [
        if (widget.enableSearchBar)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return fakeSearchBar();
              },
              childCount: 1,
            ),
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return widget.beforeWidgets?[index] ?? const SizedBox();
            },
            childCount: widget.beforeWidgets?.length ?? 0,
          ),
        ),
        if (sliverView != null) sliverView,
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              ChatUIKitListItemModelBase model = widget.list[index];

              if (model is NeedAlphabetical) {
                return SizedBox(
                  height: model.itemHeight,
                  child: widget.itemBuilder(context, model),
                );
              }

              if (model is AlphabeticalItemModel) {
                return ChatUIKitAlphabeticalListViewItem(model: model);
              }

              return widget.itemBuilder(context, model);
            },
            findChildIndexCallback: widget.findChildIndexCallback,
            childCount: widget.list.length,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return widget.afterWidgets?[index] ?? const SizedBox();
            },
            childCount: widget.afterWidgets?.length ?? 0,
          ),
        ),
      ],
    );

 

    content = NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (widget.hasMore) {
            if (controller!.position.pixels ==
                controller!.position.maxScrollExtent) {
              widget.loadMore?.call();
            }
          }
        }
        return true;
      },
      child: content,
    );

    content = Container(
      color: theme.color.isDark
          ? theme.color.neutralColor1
          : theme.color.neutralColor98,
      child: content,
    );

    return content;
  }

  Widget fakeSearchBar() {
    final theme = ChatUIKitTheme.of(context);
    return SizedBox(
      height: 44,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          List<ChatUIKitListItemModelBase> list = [];
          for (var item in widget.list) {
            if (item is NeedSearch) {
              list.add(item);
            }
          }
          widget.onSearchTap?.call(list);
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(CornerRadiusHelper.searchBarRadius(36)),
            color: theme.color.isDark
                ? theme.color.neutralColor2
                : theme.color.neutralColor95,
          ),
          height: 36,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChatUIKitImageLoader.search(
                  width: 22,
                  height: 22,
                  color: theme.color.neutralColor3,
                ),
                const SizedBox(width: 4),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.searchBarHideText ??
                        ChatUIKitLocal.conversationsViewSearchHint
                            .getString(context),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: theme.color.isDark
                          ? theme.color.neutralColor4
                          : theme.color.neutralColor6,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
