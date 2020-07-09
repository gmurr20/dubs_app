import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/model/user_search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSearchResults(
    List<UserSearchResult> searchResults,
    void Function(String) acceptFunct,
    void Function(String) declineFunct,
    void Function(String) sendRequestFunct) {
  return ListView.builder(
    padding: spacer.top.none + spacer.left.xxs + spacer.right.xxs,
    itemCount: searchResults.length,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) {
      Widget trailingWidget;
      switch (searchResults[index].state) {
        case UserRelationshipState.FRIENDS:
          trailingWidget = FlatButton(
            padding: spacer.all.none + spacer.right.xs,
            color: Colors.grey[100],
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            onPressed: () {},
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.people,
                    color: Colors.black,
                    size: 20,
                  ),
                  tooltip: 'Friends',
                  enableFeedback: true,
                  color: Colors.grey[300],
                  onPressed: () {},
                ),
                Text(
                  'Friends',
                  style: darkprimaryPBoldSmall,
                ),
              ],
            ),
          );
          break;
        case UserRelationshipState.INCOMING_INVITE:
          trailingWidget = Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 0,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FlatButton(
                    padding: spacer.all.none + spacer.right.xs,
                    color: Colors.grey[100],
                    splashColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    onPressed: () => acceptFunct(searchResults[index].userId),
                    child: Wrap(
                      // alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        IconButton(
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.person_add,
                            color: Colors.black,
                            size: 20,
                          ),
                          tooltip: 'Accept Request',
                          enableFeedback: true,
                          color: Colors.grey[300],
                          onPressed: () {},
                        ),
                        Text(
                          'Accept',
                          // textAlign: TextAlign.center,
                          style: darkprimaryPBoldSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey[400],
                  size: 20,
                ),
                tooltip: 'Decline',
                enableFeedback: true,
                color: Colors.grey[300],
                onPressed: () => declineFunct(searchResults[index].userId),
              )
            ],
          );

          break;
        case UserRelationshipState.OUTSTANDING_INVITE:
          trailingWidget = FlatButton(
            padding: spacer.all.none + spacer.right.xs,
            color: Colors.grey[100],
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            onPressed: () {},
            child: Wrap(
              // alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.people_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  tooltip: 'Pending Request',
                  enableFeedback: true,
                  color: Colors.grey[300],
                  onPressed: () {},
                ),
                Text(
                  'Pending',
                  // textAlign: TextAlign.center,
                  style: darkprimaryPBoldSmall,
                ),
              ],
            ),
          );
          break;
        case UserRelationshipState.NOT_FRIENDS:
          trailingWidget = FlatButton(
            padding: spacer.all.none + spacer.right.xs,
            color: Colors.grey[100],
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            onPressed: () => sendRequestFunct(searchResults[index].userId),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                IconButton(
                  alignment: Alignment.center,
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.black,
                    size: 20,
                  ),
                  tooltip: 'Send Friend Request',
                  enableFeedback: true,
                  color: Colors.grey[300],
                  onPressed: () {},
                ),
                Text(
                  'Add',
                  style: darkprimaryPBoldSmall,
                ),
              ],
            ),
          );

          break;
      }
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          title: Text(searchResults[index].username, style: darkprimaryPBold),
          trailing: Container(child: trailingWidget),
          contentPadding: spacer.top.xxs +
              spacer.bottom.xxs +
              spacer.left.xs +
              spacer.right.xxs,
        ),
      );
    },
  );
}
