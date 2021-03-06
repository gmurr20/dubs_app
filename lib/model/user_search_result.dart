import 'package:dubs_app/logger/log_printer.dart';

enum UserRelationshipState {
  NOT_FRIENDS,
  INCOMING_INVITE,
  OUTSTANDING_INVITE,
  FRIENDS
}

// The result from searching for a username
class UserSearchResult {
  static final _logger = getLogger("UserSearchResult");

  static UserRelationshipState friendRequestStringToEnum(String stringRep) {
    if (stringRep == "INCOMING_INVITE") {
      return UserRelationshipState.INCOMING_INVITE;
    }
    if (stringRep == "OUTSTANDING_INVITE") {
      return UserRelationshipState.OUTSTANDING_INVITE;
    }
    _logger.e(
        "friendRequestStringToEnum- unknown string for friend request '${stringRep}'");
    return UserRelationshipState.NOT_FRIENDS;
  }

  static String friendRequestEnumToString(UserRelationshipState userEnum) {
    switch (userEnum) {
      case UserRelationshipState.INCOMING_INVITE:
        {
          return "INCOMING_INVITE";
        }
      case UserRelationshipState.OUTSTANDING_INVITE:
        {
          return "OUTSTANDING_INVITE";
        }
      case UserRelationshipState.NOT_FRIENDS:
        {
          return "NOT_FRIENDS";
        }
      case UserRelationshipState.FRIENDS:
        {
          return "FRIENDS";
        }
    }
    return "";
  }

  String userId;

  String username;

  UserRelationshipState state;

  UserSearchResult(this.userId, this.username, this.state);
}
