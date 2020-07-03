import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<GlobalKey<FlipCardState>> cardStateKey = [
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
    GlobalKey<FlipCardState>(),
  ];
  List<bool> cardFlips = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  List<String> data = [
    '1',
    '1',
    '2',
    '2',
    '3',
    '3',
    '4',
    '4',
    '4',
    '4',
    '5',
    '5',
  ];

  int previousIndex = -1;
  bool flip = false;

  void _flipHandler(index) {
    if (!flip) {
      flip = true;
      previousIndex = index;
    } else {
      flip = false;
      if (previousIndex != index) {
        if (data[previousIndex] != data[index]) {
          cardStateKey[previousIndex].currentState.toggleCard();

          // if previous index in data is not equal to index in data
          previousIndex = index; // then previous index is equal to index
        } else {
          cardFlips[previousIndex] = false;
          cardFlips[index] = false;
          if (cardFlips.every((e) => e == false)) {
            print('Won');
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    data.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) => FlipCard(
                  key: cardStateKey[index],
                  onFlip: () {
                    _flipHandler(index);
                  },
                  flipOnTouch: cardFlips[index],
                  front: Container(
                    margin: EdgeInsets.all(3),
                    color: Colors.deepOrange[300],
                  ),
                  back: Container(
                    margin: EdgeInsets.all(3),
                    color: Colors.deepOrange,
                    child: Center(
                      child: Text(
                        '${data[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
