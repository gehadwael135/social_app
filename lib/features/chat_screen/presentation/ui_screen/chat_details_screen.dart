import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat_screen/domain/entities/message_model.dart';
import 'package:social_app/features/chat_screen/presentation/controler/cubit/chat_cubit.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isFirstLoad = true;
  final ValueNotifier<bool> _showScrollButton = ValueNotifier(false);

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    _showScrollButton.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final isNotAtBottom =
          _scrollController.offset <
          _scrollController.position.maxScrollExtent - 100;

      _showScrollButton.value = isNotAtBottom;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    var cubit = context.read<ChatCubit>();
    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xffF5F7FB),

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            titleSpacing: 0,

            title: Row(
              children: [
                CircleAvatar(
                  radius: 21,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    widget.receiverName.isNotEmpty
                        ? widget.receiverName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  widget.receiverName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          body: BlocListener<ChatCubit, ChatState>(
            listener: (context, state) {},
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageModel>>(
                    stream: cubit.getMessages(widget.receiverId),

                    builder: (context, snapshot) {
                      //auto scroll to the last message
                      if (_isFirstLoad && cubit.messages.isNotEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_scrollController.hasClients) {
                            _scrollController.jumpTo(
                              _scrollController.position.maxScrollExtent,
                            );
                            _isFirstLoad = false;
                          }
                        });
                      }
                      return BlocBuilder<ChatCubit, ChatState>(
                        builder: (context, state) {
                          final messages = cubit.messages;
                          return Column(
                            children: [
                              if (cubit.hasMoreMessages)
                                TextButton(
                                  onPressed: cubit.isLoadingMore
                                      ? null
                                      : () async {
                                          await cubit.loadMoreMessages(
                                            widget.receiverId,
                                          );
                                        },
                                  child: cubit.isLoadingMore
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text('Load More'),
                                ),
                              Expanded(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),

                                  itemCount: messages.length,

                                  itemBuilder: (context, index) {
                                    final message = messages[index];

                                    final isMe =
                                        message.senderId ==
                                        FirebaseAuth.instance.currentUser!.uid;

                                    return Align(
                                      alignment: isMe
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,

                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.75,
                                        ),

                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),

                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 12,
                                        ),

                                        decoration: BoxDecoration(
                                          color: isMe
                                              ? Colors.blue
                                              : Colors.white,

                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(18),
                                            topRight: const Radius.circular(18),
                                            bottomLeft: Radius.circular(
                                              isMe ? 18 : 4,
                                            ),
                                            bottomRight: Radius.circular(
                                              isMe ? 4 : 18,
                                            ),
                                          ),

                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.05,
                                              ),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),

                                        child: Text(
                                          message.text,
                                          style: TextStyle(
                                            color: isMe
                                                ? Colors.white
                                                : Colors.black87,
                                            fontSize: 15,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),

                    child: BlocBuilder<ChatCubit, ChatState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: messageController,
                                    focusNode: cubit.focusNode,
                                    textInputAction: TextInputAction.send,

                                    onSubmitted: (_) {
                                      _sendMessage();
                                    },

                                    decoration: InputDecoration(
                                      hintText: 'Write a message...',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                      ),

                                      filled: true,
                                      fillColor: const Color(0xffF3F5F8),

                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: 13,
                                          ),

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide.none,
                                      ),

                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide.none,
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      cubit.hideEmojiPicker();
                                    },
                                  ),
                                ),

                                const SizedBox(width: 6),

                                Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25),

                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(25),

                                    onTap: _sendMessage,

                                    child: const SizedBox(
                                      width: 50,
                                      height: 50,

                                      child: Icon(
                                        Icons.send_rounded,
                                        color: Colors.white,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Material(
                                  color: Colors.amber[400],
                                  borderRadius: BorderRadius.circular(25),

                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(25),

                                    onTap: () {
                                      cubit.toggleEmojiPicker();
                                    },

                                    child: SizedBox(
                                      width: 50,
                                      height: 50,

                                      child: Icon(
                                        cubit.isEmojiPickerVisible
                                            ? Icons.keyboard
                                            : Icons.emoji_emotions,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (cubit.isEmojiPickerVisible && !isKeyboardOpen)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),

                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: SizedBox(
                                    height: 290,
                                    width: .infinity, // Adjust height as needed
                                    child: EmojiPicker(
                                      textEditingController: messageController,
                                      config: const Config(
                                        height: 250,
                                        checkPlatformCompatibility: true,
                                        emojiViewConfig: EmojiViewConfig(
                                          columns: 7,
                                          emojiSizeMax: 32,
                                        ),
                                        skinToneConfig: SkinToneConfig(
                                          enabled: true,
                                        ),
                                        categoryViewConfig: CategoryViewConfig(
                                          backgroundColor: Color(0xFFF2F2F2),
                                        ),
                                        bottomActionBarConfig:
                                            BottomActionBarConfig(
                                              enabled: false,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 130,
          child: ValueListenableBuilder<bool>(
            valueListenable: _showScrollButton,
            builder: (context, showButton, child) {
              if (!showButton) {
                return const SizedBox.shrink();
              }

              return FloatingActionButton.small(
                backgroundColor: Colors.grey[850],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                child: const Icon(
                  Icons.keyboard_double_arrow_down,
                  color: Colors.white,
                  size: 30,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    final text = messageController.text.trim();

    if (text.isEmpty) {
      return;
    }

    context.read<ChatCubit>().sendMessage(
      receiverId: widget.receiverId,
      text: text,
    );

    messageController.clear();
  }
}
