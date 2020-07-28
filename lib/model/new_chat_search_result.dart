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
  @override
  int get hashCode {
    return userId.hashCode;
  }

  @override
  bool operator ==(dynamic other) {
    return this.userId == other.userId;
  }

  NewChatSearchResult(
      this.userId, this.username, this.iconInitials, this.isSelected);
}
