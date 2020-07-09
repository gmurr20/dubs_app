class NewChatSearchResult {
  // the users id
  String userId;

  // username
  String username;

  // initials of people in the chat
  String iconInitials;

  // is the user selected
  bool isSelected;

  NewChatSearchResult(
      this.userId, this.username, this.iconInitials, this.isSelected);
}
