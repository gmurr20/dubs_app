class NewChatSearchResult {
  // the users id
  String userId;

  // username
  String username;

  // initials of people in the chat
  String iconInitials;

  // is the user selected
  bool isSelected;

  // override the hash code
  int get hashCode {
    return userId.hashCode;
  }

  NewChatSearchResult(
      this.userId, this.username, this.iconInitials, this.isSelected);
}
