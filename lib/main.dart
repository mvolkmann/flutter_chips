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
  bool selected;
  String text;

  ChipOption({
    this.color = Colors.black,
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
  late List<ChipOption> chipOptions;
  late List<FilterChip> filterChips;
  final inputChips = <InputChip>[];

  @override
  void initState() {
    super.initState();
    makeInputChip('Red', Colors.red);
    makeInputChip('Green', Colors.green);
    makeInputChip('Blue', Colors.blue);

    chipOptions = [
      ChipOption(text: 'Red', color: Colors.red),
      ChipOption(text: 'Orange', color: Colors.orange),
      ChipOption(text: 'Green', color: Colors.green),
      ChipOption(text: 'Blue', color: Colors.blue),
      ChipOption(text: 'Purple', color: Colors.purple),
    ];
  }

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

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          children: [
            Wrap(
              children: <Widget>[
                makeChip('Chocolate', Colors.brown),
                makeActionChip(
                  'Vanilla',
                  Colors.deepOrange,
                  () => print('got press'),
                ),
                makeChip('Strawberry', Colors.pink),
                makeChip('Blueberry', Colors.blue),
                makeChip('Kiwi', Colors.green),
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

  Widget makeActionChip(String text, Color bgColor, VoidCallback onPressed) =>
      ActionChip(
        avatar: Icon(Icons.ac_unit, color: Colors.white),
        backgroundColor: bgColor,
        elevation: 5,
        label: Text(text),
        labelStyle: TextStyle(color: Colors.white),
        onPressed: onPressed,
      );

  Widget makeChip(String text, Color bgColor) => Chip(
        backgroundColor: bgColor,
        elevation: 5,
        label: Text(text),
        labelStyle: TextStyle(color: Colors.white),
      );

  Widget makeInputChip(String text, Color color) {
    late InputChip thisChip; // used by onDeleted
    final chip = InputChip(
      backgroundColor: Colors.grey[300],
      elevation: 5,
      label: Text(text),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
      onDeleted: () {
        setState(() => inputChips.remove(thisChip));
      },
    );
    thisChip = chip; // set for use in onDeleted
    inputChips.add(chip);
    return chip;
  }
}
