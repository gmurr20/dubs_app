import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShareForm extends StatefulWidget {
  // add any state here

  ShareForm({Key key}) : super(key: key);

  @override
  State<ShareForm> createState() => _ShareFormState();
}

class _ShareFormState extends State<ShareForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
          backdropEnabled: true,
          backdropColor: DarwinWhite,
          backdropOpacity: .8,
          backdropTapClosesPanel: true,
          color: Colors.black87,
          minHeight:
              150, // Need to chnge this to 0 when we integrate with a button/action.
          maxHeight: 150,
          padding: (spacer.left.md + spacer.top.xs),
          header: Text(
            'Share',
            style: primaryPBold,
          ),
          panel: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    splashColor: Colors.grey[200], // inkwell color
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.email,
                          semanticLabel: 'email',
                          size: 30.0,
                          color: DarwinWhite),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.green[500], // button color
                  child: InkWell(
                    splashColor: Colors.grey[200], // inkwell color
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.message,
                          semanticLabel: 'messages',
                          size: 30.0,
                          color: DarwinWhite),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.red[500], // button color
                  child: InkWell(
                    splashColor: Colors.grey[200], // inkwell color
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.content_copy,
                          semanticLabel: 'copy link',
                          size: 30.0,
                          color: DarwinWhite),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              ClipOval(
                child: Material(
                  color: Colors.grey, // button color
                  child: InkWell(
                    splashColor: Colors.grey[200], // inkwell color
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.more_horiz,
                          semanticLabel: 'more options',
                          size: 30.0,
                          color: DarwinWhite),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
