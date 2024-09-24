import 'package:em_chat_uikit/chat_uikit.dart';
import 'package:em_chat_uikit_example/demo/home_page.dart';

import 'package:em_chat_uikit_example/sample_demo/contact/contact_depth_custom_page.dart';
import 'package:em_chat_uikit_example/sample_demo/contact/contact_page_custom1.dart';
import 'package:em_chat_uikit_example/sample_demo/conversation/merge_conversation_page.dart';
import 'package:em_chat_uikit_example/sample_demo/group/group_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../demo/pages/contact/contact_page.dart';
import '../demo/pages/conversation/conversation_page.dart';

class CustomHomePage extends StatefulWidget {
  const CustomHomePage({super.key});

  @override
  State<CustomHomePage> createState() => _CustomHomePageState();
}

class _CustomHomePageState extends State<CustomHomePage>
    with ChatUIKitThemeMixin {
  @override
  void initState() {
    super.initState();
  }

  bool isLightTheme = true;
  List<String> fontSizeList = ['0', '1', '2', '3'];
  String fontSize = '1';
  ChatUIKitFontSize size = ChatUIKitFontSize.normal;
  @override
  Widget themeBuilder(BuildContext context, ChatUIKitTheme theme) {
    Widget content = Scaffold(
      backgroundColor: theme.color.isDark
          ? theme.color.neutralColor1
          : theme.color.neutralColor98,
      appBar: AppBar(
        title: Text(
          'Sample Demo',
          style: TextStyle(
            color: theme.color.isDark
                ? theme.color.neutralColor98
                : theme.color.neutralColor0,
          ),
        ),
        backgroundColor: theme.color.isDark
            ? theme.color.neutralColor1
            : theme.color.neutralColor98,
      ),
      body: ListView(
        children: [
          itemWidget(
            name: '默认会话列表(Default Conversation list)',
            title: 'ConversationPage',
            widget: const ConversationPage(),
          ),
          itemWidget(
            name: '合并会话列表(Merge Conversation list)',
            title: 'MergeConversationPage',
            widget: const MergeConversationPage(),
          ),
          itemWidget(
            name: '默认通讯录列表(Default Contact list)',
            title: 'ContactPage',
            widget: const ContactPage(),
          ),
          itemWidget(
            name: '通讯录和群列表(Contact list and group list)',
            title: 'ContactAndGroupPage',
            widget: const ContactAndGroupPage(),
          ),
          itemWidget(
            name: '通讯录自定义AppBar(custom contacts app bar)',
            title: 'CustomContactAppBarPage',
            widget: const CustomContactAppBarPage(),
          ),
          itemWidget(
            name: '通讯录深度自定义(depth custom contacts)',
            title: 'ContactDepthCustomPage',
            widget: const ContactDepthCustomPage(),
          ),
          itemWidget(
              name: '默认群组列表(Default group list)',
              title: 'Groups View',
              widget: const GroupPage()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '修改主题颜色(Switch theme color)',
                style: TextStyle(
                  color: theme.color.isDark
                      ? theme.color.neutralColor98
                      : theme.color.neutralColor0,
                ),
              ),
              CupertinoSwitch(
                  value: theme.color.isDark,
                  onChanged: (value) {
                    if (value) {
                      ChatUIKitTheme.instance.setColor(ChatUIKitColor.dark());
                    } else {
                      ChatUIKitTheme.instance.setColor(ChatUIKitColor.light());
                    }
                  }),
            ],
          ),
          fontSizeSettingsWidget(),
          itemWidget(
            name: '演示Demo',
            title: 'Demo',
            widget: const HomePage(),
          ),
        ],
      ),
    );

    return content;
  }

  Widget itemWidget({
    required String name,
    required String title,
    required Widget widget,
  }) {
    return Column(
      children: [
        Text(name),
        Container(
          color: theme.color.isDark
              ? theme.color.neutralColor3
              : theme.color.neutralColor7,
          height: 44,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                      backgroundColor: theme.color.isDark
                          ? theme.color.neutralColor1
                          : theme.color.neutralColor98,
                      title: Text(
                        title,
                        style: TextStyle(
                          color: theme.color.isDark
                              ? theme.color.neutralColor98
                              : theme.color.neutralColor0,
                        ),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: theme.color.isDark
                              ? theme.color.neutralColor98
                              : theme.color.neutralColor0,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),
                  body: widget,
                );
              }),
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.color.isDark
                      ? theme.color.neutralColor98
                      : theme.color.neutralColor0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget fontSizeSettingsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '修改字号(Set font size) ${() {
              switch (size) {
                case ChatUIKitFontSize.small:
                  return 'small';
                case ChatUIKitFontSize.normal:
                  return 'normal';
                case ChatUIKitFontSize.large:
                  return 'large';
                case ChatUIKitFontSize.superLarge:
                  return 'superLarge';
              }
            }()}',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: theme.color.isDark
                  ? theme.color.neutralColor98
                  : theme.color.neutralColor0,
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Slider(
            value: double.parse(fontSize).toInt().toDouble(),
            min: 0,
            max: 3,
            // 设置分割数量
            divisions: 3,
            // 设置标签
            label: () {
              ChatUIKitFontSize size =
                  ChatUIKitFontSize.values[double.parse(fontSize).toInt()];
              switch (size) {
                case ChatUIKitFontSize.small:
                  return 'small';
                case ChatUIKitFontSize.normal:
                  return 'normal';
                case ChatUIKitFontSize.large:
                  return 'large';
                case ChatUIKitFontSize.superLarge:
                  return 'superLarge';
              }
            }(),
            onChanged: (value) {
              fontSize = value.toString();
              size = ChatUIKitFontSize.values[double.parse(fontSize).toInt()];
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
