import 'package:flutter/material.dart';
import 'package:thamhuai/utility/tool_utility.dart';

//ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  String text;
  Color color;
  IconData icon;
  Function onClick;

  CustomButton({
    Key key,
    this.text,
    this.color,
    this.icon,
    this.onClick,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: !(ToolUtility.stringIsNullOrEmpty(widget.icon)),
            child: Container(
              margin: EdgeInsets.only(right: ToolUtility.autoSize(context, ToolUtility.responsive1px * 5)),
              child: Icon(
                widget.icon,
                color: ToolUtility.colorWhite,
                size: ToolUtility.autoSize(context, ToolUtility.iconSizeNormal),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              widget.text,
              style: TextStyle(
                color: ToolUtility.colorWhite,
                fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeButton),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ToolUtility.autoSize(context, ToolUtility.buttonBorderRadius)),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(widget.color),
      ),
      onPressed: widget.onClick,
    );
  }
}
