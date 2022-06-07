import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
class DropDownListExample extends StatefulWidget {
  final kHint;
  final List<SelectedListItem> dropdownl;
  const DropDownListExample({
    Key? key, this.kHint, required this.dropdownl,
  }) : super(key: key);

  @override
  _DropDownListExampleState createState() => _DropDownListExampleState(kHint,dropdownl);
}

class _DropDownListExampleState extends State<DropDownListExample> {
  /// This is list of city which will pass to the drop down.

  final TextEditingController _cityTextEditingController =
  TextEditingController();
  final kHint;
  final List<SelectedListItem> dropdownl;
  _DropDownListExampleState(this.kHint, this.dropdownl);

  @override
  void dispose() {
    super.dispose();
    _cityTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _mainBody(),
    );
  }

  /// This is Main Body widget.
  Widget _mainBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            textEditingController: _cityTextEditingController,
            hint: kHint,
            isCitySelected: true,
            ddList: dropdownl,
          ),

        ],
      ),
    );
  }
}
class AppTextField extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();

  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? ddList;
  AppTextField({
    required this.textEditingController,
    required this.hint,
    required this.isCitySelected,
    required this.ddList,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final TextEditingController _searchTextEditingController = TextEditingController();

  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: kDone,
        submitButtonColor: const Color.fromRGBO(70, 76, 222, 1),
        searchHintText: kSearch,
        bottomSheetTitle: widget.hint,
        searchBackgroundColor: Colors.black12,
        dataList: widget.ddList ?? [],
        selectedItems: (List<dynamic> selectedList) {
          showSnackBar(selectedList.toString());
        },
        selectedItem: (String selected) {
          showSnackBar(selected);
          widget.textEditingController.text = selected;
        },
        enableMultipleSelection: true,
        searchController: _searchTextEditingController,

      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: true,
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
            FocusScope.of(context).unfocus();
            onTextFieldTap();
          }
              : null,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.arrow_drop_down_outlined),
            filled: true,
            fillColor: const Color(0xffb1e6ffff),

            hintText: widget.hint,
            hintStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.lime,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}