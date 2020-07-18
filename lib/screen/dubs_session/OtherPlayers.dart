import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';

class OtherPlayers extends StatelessWidget {
  OtherPlayers({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        alignment: Alignment.topLeft,
        padding: spacer.top.xs,
        margin: spacer.left.xs + spacer.right.xs,
        child: Stack(children: [
          Container(
            padding: spacer.left.xs + spacer.top.xs + spacer.bottom.xs,
            child: Container(
              alignment: Alignment.topLeft,
              padding: spacer.top.xxs,
              margin: spacer.left.none,
              child: Text(
                "Players",
                style: darkPrimaryH1Bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: spacer.top.xs + spacer.bottom.xs,
            margin: spacer.right.md,
            child: Container(
              width: 45,
              child: FlatButton(
                padding: spacer.all.none + spacer.right.none,
                color: Colors.white,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                onPressed: () {},
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    Text(
                      'Add',
                      // textAlign: TextAlign.center,
                      style: darkprimaryPBoldSmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: spacer.bottom.xxs,
        child: ListTile(
          title: Text('BMAC2233', style: darkprimaryPBold),
          trailing: FlatButton(
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
                  // textAlign: TextAlign.center,
                  style: darkprimaryPBoldSmall,
                ),
              ],
            ),
          ),
          contentPadding: spacer.top.xxs +
              spacer.bottom.xxs +
              spacer.left.xs +
              spacer.right.xxs,
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: spacer.bottom.xxs,
        child: ListTile(
          title: Text('Gmilli20', style: darkprimaryPBold),
          trailing: FlatButton(
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
                  // textAlign: TextAlign.center,
                  style: darkprimaryPBoldSmall,
                ),
              ],
            ),
          ),
          contentPadding: spacer.top.xxs +
              spacer.bottom.xxs +
              spacer.left.xs +
              spacer.right.xxs,
        ),
      ),
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: spacer.bottom.xxl,
        child: ListTile(
          title: Text('Spookycactus', style: darkprimaryPBold),
          trailing: FlatButton(
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
                  // textAlign: TextAlign.center,
                  style: darkprimaryPBoldSmall,
                ),
              ],
            ),
          ),
          contentPadding: spacer.top.xxs +
              spacer.bottom.xxs +
              spacer.left.xs +
              spacer.right.xxs,
        ),
      )
    ]);
  }
}
