import 'package:chatter/ui/common/avatar_placeholder_view.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: ChannelsBloc(
        child: ChannelListView(
          channelPreviewBuilder: (context, channel) {
            return Container(
              color: Theme.of(context).canvasColor,
              child: ChannelPreview(
                
                onImageTap: () {
                  String? name;
                  String? image;
                  final currenUser = StreamChat.of(context).client.state.currentUser;
                  if(channel.isGroup){
                      name = channel.extraData['name'] as String?;
                      image = channel.extraData['image'] as String?;
                  }else{
                    final friend = channel.state!.members.where((element) => element.userId != currenUser!.id).first.user;
                    name = friend?.name;
                      image = friend?.extraData['image'] as String?;
                  }
                  
                  

                  print('image tap');
                  
                  Navigator.of(context).push(PageRouteBuilder(
                      barrierDismissible: true,
                      opaque: false,
                      barrierColor: Colors.black45,
                      pageBuilder: (context, animation1, _) {
                        return StreamChannel(
                            channel: channel,
                            child: FadeTransition(
                                opacity: animation1,
                                child: ChatDetailView(
                                  channelId: channel.id,
                                  image: image ,
                                  name: name ?? 'Chat Name',
                                )));
                      }));
                },
                channel: channel,
                onTap: (channel) {
                  print('just tap');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return StreamChannel(child: ChannelPage(), channel: channel);
                  }));
                },
              ),
            );
          },
          filter:
              Filter.in_('members', [StreamChat.of(context).currentUser!.id]),
          sort: [SortOption('last_message_at')],
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: ChannelHeader(),
        body: Column(
          children: [
            Expanded(child: MessageListView()),
            MessageInput(),
          ],
        ));
  }
}

class ChatDetailView extends StatelessWidget {
  final String? image;
  final String? name;
  final String? channelId;

  const ChatDetailView({Key? key, this.image, this.name, this.channelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image != null
                  ? Hero(child: ClipOval(child: Image.network(image!, height: 180, width: 180, fit: BoxFit.cover,)), tag: channelId!, )
                  : AvatarPlaceholder(onTap: () {}, child: Icon(Icons.person_outline, size: 60,)),
                  SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[200],

                ),
                width: 300,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(name!, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),),
                      Spacer(),
                      CircleAvatar(backgroundColor: Theme.of(context).accentColor,child: Icon(Icons.message_outlined)),
                      SizedBox(width: 10,),
                      CircleAvatar(backgroundColor: Theme.of(context).accentColor,child: Icon(Icons.call_outlined)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
