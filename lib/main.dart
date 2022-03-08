import 'package:flutter/material.dart';
import './extensions/widget_extensions.dart';

const spacing = 10.0;
const title = 'My App';

void main() => runApp(
      MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const Home(),
      ),
    );

class ChipOption {
  Color color;
  bool deleted;
  bool selected;
  String text;

  ChipOption({
    this.color = Colors.black,
    this.deleted = false,
    this.selected = false,
    required this.text,
  });
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ChipOption> actionOptions = buildOptions();
  final List<ChipOption> chipOptions = buildOptions();
  final List<ChipOption> choiceOptions = buildOptions();
  final List<ChipOption> filterOptions = buildOptions();
  final List<ChipOption> inputOptions = buildOptions();

  late List<ActionChip> actionChips;
  late List<Chip> chips;
  late List<ChoiceChip> choiceChips;
  late List<FilterChip> filterChips;
  late List<InputChip> inputChips;

  @override
  Widget build(BuildContext context) {
    const elevation = 5.0;

    actionChips = actionOptions
        .where((option) => !option.deleted)
        .map(
          (option) => ActionChip(
            backgroundColor: option.color.withOpacity(0.2),
            elevation: elevation,
            label: Text(option.text),
            labelStyle: TextStyle(
              color: option.color,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () => print('You pressed ${option.text}'),
          ),
        )
        .toList();

    chips = chipOptions
        .where((option) => !option.deleted)
        .map(
          (option) => Chip(
            backgroundColor: option.color.withOpacity(0.2),
            elevation: elevation,
            label: Text(option.text),
            labelStyle: TextStyle(
              color: option.color,
              fontWeight: FontWeight.bold,
            ),
            onDeleted: () {
              setState(() => option.deleted = true);
            },
          ),
        )
        .toList();

    choiceChips = choiceOptions
        .map(
          (option) => ChoiceChip(
            backgroundColor: option.color.withOpacity(0.2),
            elevation: elevation,
            label: Text(option.text),
            labelStyle: TextStyle(
              color: option.selected ? Colors.grey[700] : option.color,
              fontWeight: FontWeight.bold,
            ),
            selected: option.selected,
            selectedColor: option.color.withOpacity(0.6),
            onSelected: (bool selected) {
              setState(() {
                // It's on YOU to ensure that only one is selected!
                for (var opt in choiceOptions) {
                  opt.selected = false;
                }
                option.selected = selected;
              });
            },
          ),
        )
        .toList();

    filterChips = filterOptions
        .map(
          (option) => FilterChip(
            backgroundColor: option.color.withOpacity(0.2),
            checkmarkColor: option.color,
            elevation: elevation,
            label: Text(option.text),
            labelStyle: TextStyle(
              color: option.selected ? Colors.grey[700] : option.color,
              fontWeight: FontWeight.bold,
            ),
            selected: option.selected,
            selectedColor: option.color.withOpacity(0.6),
            onSelected: (bool selected) {
              setState(() => option.selected = selected);
            },
          ),
        )
        .toList();

    inputChips = inputOptions
        .where((option) => !option.deleted)
        .map(
          (option) => InputChip(
            backgroundColor: option.color.withOpacity(0.2),
            elevation: elevation,
            label: Text(option.text),
            labelStyle: TextStyle(
              color: option.color,
              fontWeight: FontWeight.bold,
            ),
            onDeleted: () {
              setState(() => option.deleted = true);
            },
            // Can't specify both onPressed and onSelected.
            //onPressed: () => print('You pressed ${option.text}'),
            selected: option.selected,
            selectedColor: option.color.withOpacity(0.6),
            onSelected: (bool selected) {
              setState(() => option.selected = selected);
            },
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          children: [
            buildLabel('ActionChips'),
            Wrap(children: actionChips, spacing: spacing),
            buildLabel('Chips'),
            Wrap(children: chips, spacing: spacing),
            buildLabel('ChoiceChips'),
            Wrap(children: choiceChips, spacing: spacing),
            buildLabel('FilterChips'),
            Wrap(children: filterChips, spacing: spacing),
            buildLabel('InputChips'),
            Wrap(children: inputChips, spacing: spacing),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) => Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ).margin(EdgeInsets.only(top: 20));

  static List<ChipOption> buildOptions() => [
        ChipOption(text: 'Red', color: Colors.red),
        ChipOption(text: 'Orange', color: Colors.orange),
        ChipOption(text: 'Green', color: Colors.green),
        ChipOption(text: 'Blue', color: Colors.blue),
        ChipOption(text: 'Purple', color: Colors.purple),
      ];
}
