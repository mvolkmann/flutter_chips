import 'package:flutter/material.dart';

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
  final List<ChipOption> chipOptions = [
    ChipOption(text: 'Red', color: Colors.red),
    ChipOption(text: 'Orange', color: Colors.orange),
    ChipOption(text: 'Green', color: Colors.green),
    ChipOption(text: 'Blue', color: Colors.blue),
    ChipOption(text: 'Purple', color: Colors.purple),
  ];
  late List<FilterChip> filterChips;
  late List<InputChip> inputChips;

  @override
  Widget build(BuildContext context) {
    filterChips = chipOptions
        .map(
          (option) => FilterChip(
            backgroundColor: option.color.withOpacity(0.2),
            checkmarkColor: option.color,
            elevation: 5,
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

    inputChips = chipOptions
        .where((option) => !option.deleted)
        .map(
          (option) => InputChip(
            backgroundColor: Colors.grey[300],
            elevation: 5,
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

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                buildChip('Chocolate', Colors.brown),
                buildActionChip(
                  'Vanilla',
                  Colors.deepOrange,
                  () => print('got press'),
                ),
                buildChip('Strawberry', Colors.pink),
                buildChip('Blueberry', Colors.blue),
                buildChip('Kiwi', Colors.green),
              ],
              spacing: spacing,
            ),
            Wrap(children: inputChips, spacing: spacing),
            Wrap(children: filterChips, spacing: spacing),
            //TODO: Add ChoiceChips.
          ],
        ),
      ),
    );
  }

  Widget buildActionChip(String text, Color bgColor, VoidCallback onPressed) =>
      ActionChip(
        avatar: Icon(Icons.ac_unit, color: Colors.white),
        backgroundColor: bgColor,
        elevation: 5,
        label: Text(text),
        labelStyle: TextStyle(color: Colors.white),
        onPressed: onPressed,
      );

  Widget buildChip(String text, Color bgColor) => Chip(
        backgroundColor: bgColor,
        elevation: 5,
        label: Text(text),
        labelStyle: TextStyle(color: Colors.white),
      );
}
