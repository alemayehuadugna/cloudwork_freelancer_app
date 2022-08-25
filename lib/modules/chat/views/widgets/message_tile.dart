import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class MessageTile extends StatefulWidget {
  const MessageTile({
    Key? key,
    required this.message,
    required this.sentTime,
    required this.isSender,
  }) : super(key: key);

  final String message;
  final DateTime sentTime;
  final bool isSender;

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  Timer? timer;
  String sentAt = '';

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 55), (Timer t) {
      // print("timer is behaving oddly");
      setState(() {
        sentAt = Jiffy(widget.sentTime).fromNow();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sentAt = Jiffy(widget.sentTime).fromNow();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            widget.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (widget.isSender) const SizedBox(width: 50),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: widget.isSender
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: widget.isSender
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    sentAt,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.7),
                        ),
                  )
                ],
              ),
            ),
          ),
          if (!widget.isSender) const SizedBox(width: 50),
        ],
      ),
    );
  }
}
