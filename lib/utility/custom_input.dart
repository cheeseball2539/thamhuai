
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thamhuai/utility/tool_utility.dart';

//ignore: must_be_immutable
class CustomInput extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  Widget prefixIcon, suffixIcon;
  List inputFormatters;
  Color focusColor;
  Function onChange;

  CustomInput({
    Key key,
    this.controller,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.focusColor,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      inputFormatters: widget.inputFormatters,
      style: TextStyle(
        fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
        color: ToolUtility.colorGreyCustom1,
      ),
      decoration: InputDecoration(
        prefixIcon: ToolUtility.stringIsNullOrEmpty(widget.prefixIcon)
            ? null
            : Padding(
                padding: EdgeInsets.all(ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
                child: widget.prefixIcon,
              ),
        counterText: "",
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: ToolUtility.autoSize(context, ToolUtility.fontSizeNormal),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusColor),
          borderRadius: BorderRadius.circular(ToolUtility.autoSize(context, ToolUtility.responsive1px * 5)),
        ),
        alignLabelWithHint: true,
        border: ToolUtility.borderInput(context),
        contentPadding: EdgeInsets.all(ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
        suffixIcon: ToolUtility.stringIsNullOrEmpty(widget.suffixIcon)
            ? null
            : Padding(
                padding: EdgeInsets.all(ToolUtility.autoSize(context, ToolUtility.responsive1px * 10)),
                child: widget.suffixIcon,
              ),
      ),
      onChanged: widget.onChange,
    );
  }
}
