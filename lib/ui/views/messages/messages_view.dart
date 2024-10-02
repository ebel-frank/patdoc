import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:patdoc/ui/views/messages/messages_view.form.dart';
import 'package:patdoc/ui/views/messages/messages_viewmodel.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'message'),
  ],
)
class MessagesView extends StatelessWidget with $MessagesView {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessagesViewModel>.reactive(
      viewModelBuilder: () => MessagesViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.init();
        syncFormWithViewModel(viewModel);
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Messages',
            style: AppStyles.blackW500(20),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: AppColors.whiteColor,
          automaticallyImplyLeading: true,
        ),
        body: ListView.builder(
          reverse: true,
          itemCount: viewModel.messagesList.length,
          itemBuilder: (context, index) {
            return MessageBubble(
              sender: viewModel.messagesList[index].sender ==
                      viewModel.currentUserRole
                  ? 'You'
                  : '',
              text: viewModel.messagesList[index].message,
              isMe: viewModel.messagesList[index].sender ==
                  viewModel.currentUserRole,
              time: viewModel.convertDate(
                viewModel.messagesList[index].timestamp,
              ),
            );
          },
        ),
        bottomSheet: TextField(
          controller: messageController,
          decoration: InputDecoration(
            hintText: 'Type a message',
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: AppColors.greyColor,
            prefixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.emoji_emotions_outlined),
            ),
            suffixIcon: IconButton(
              onPressed: viewModel.sendMessage,
              icon: const Icon(Icons.send_outlined),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
    required this.time,
  });

  final String sender;
  final String text;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender   ',
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.black54,
            ),
          ),
          2.verticalSpace,
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlue : Colors.blueGrey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 10.0,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}

const kSendButtonTextStyle = TextStyle(
  color: kPrimaryLight,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryLight, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  prefixIcon: Icon(
    Icons.email_rounded,
    color: kPrimaryLight,
  ),
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimary, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kPrimary, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);

const kPrimary = Color(0xFF181033);
const kPrimaryLight = Color(0xFF776bff);
