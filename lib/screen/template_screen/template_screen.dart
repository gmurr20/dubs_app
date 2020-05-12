import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dubs_app/DesignSystem/texts.dart';
import 'package:dubs_app/DesignSystem/colors.dart';
import 'package:dubs_app/DesignSystem/dimensions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../DesignSystem/colors.dart';
import '../../DesignSystem/colors.dart';
import '../../DesignSystem/texts.dart';
import '../../DesignSystem/texts.dart';

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
          backdropColor: DarwinBlack,
          backdropOpacity: .8,
          backdropTapClosesPanel: true,
          color: Colors.black87,
          minHeight: 150,
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
              Icon(Icons.email,
                  semanticLabel: 'email', size: 40.0, color: DarwinWhite),
              Icon(
                Icons.message,
                semanticLabel: 'messages',
                size: 40.0,
                color: DarwinWhite,
              ),
              Icon(
                Icons.content_copy,
                semanticLabel: 'copy link',
                size: 40.0,
                color: DarwinWhite,
              ),
              Icon(
                Icons.more_horiz,
                semanticLabel: 'more options',
                size: 40.0,
                color: DarwinWhite,
              ),
            ],
          )),
    );
  }
}
