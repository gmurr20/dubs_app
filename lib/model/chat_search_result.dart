import 'package:dubs_app/logger/log_printer.dart';

// The result from searching for a username
class ChatSearchResult {
  static final _logger = getLogger("ChatSearchResult");

  // initials of people in the chat
  String iconInitials;

  // the chat name
  String chatName;

  // last message timestamp
  String lastMessage;

  // last message timestamp
  String lastMessageTimestamp;

  // the chat id
  String chatId;

  ChatSearchResult(this.iconInitials, this.chatName, this.lastMessage,
      this.lastMessageTimestamp, this.chatId);
}
