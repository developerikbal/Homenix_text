import 'package:flutter/material.dart';

/// InputChipList: ব্যবহারকারী একাধিক বিকল্প ইনপুট দিতে পারবে যেমন উপসর্গ, রুব্রিক ইত্যাদি
class InputChipList extends StatefulWidget {
  final List<String> options; // সকল চিপ অপশন
  final Function(List<String>) onSelectionChanged; // নির্বাচনের পরে রেসপন্স
  final List<String> initialSelected; // পূর্বনির্ধারিত সিলেকশন

  const InputChipList({
    Key? key,
    required this.options,
    required this.onSelectionChanged,
    this.initialSelected = const [],
  }) : super(key: key);

  @override
  State<InputChipList> createState() => _InputChipListState();
}

class _InputChipListState extends State<InputChipList> {
  late List<String> selectedOptions;

  @override
  void initState() {
    super.initState();
    selectedOptions = List.from(widget.initialSelected);
  }

  // চিপ ট্যাপ করলে সিলেকশন টগল হয়
  void _onChipTapped(String option) {
    setState(() {
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
    });

    widget.onSelectionChanged(selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.options.map((option) {
        final isSelected = selectedOptions.contains(option);

        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => _onChipTapped(option),
          selectedColor: Theme.of(context).primaryColor.withOpacity(0.7),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}