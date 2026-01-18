import 'dart:math';
import 'package:flutter/material.dart';
import 'tile.dart';
import 'tile_data.dart';
import 'keyboard.dart';
import 'word_list.dart';

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  late String answer;
  int row = 0;
  int col = 0;

  final disabledKeys = <String>{};

  final grid = List.generate(
    6,
    (_) => List.generate(5, (_) => TileData('', Colors.grey.shade900)),
  );

  @override
  void initState() {
    super.initState();
    answer = wordList[Random().nextInt(wordList.length)];
  }

  void onKey(String k) {
    if (row == 6 || col == 5) return;
    setState(() {
      grid[row][col].letter = k;
      col++;
    });
  }

  void backspace() {
    if (col == 0) return;
    setState(() {
      col--;
      grid[row][col].letter = '';
    });
  }

  Future<void> submit() async {
    if (col != 5) return;

    final guess = grid[row].map((t) => t.letter).join();

    final freq = <String, int>{};
    for (final c in answer.split('')) {
      freq[c] = (freq[c] ?? 0) + 1;
    }

    for (int i = 0; i < 5; i++) {
      if (guess[i] == answer[i]) {
        freq[guess[i]] = freq[guess[i]]! - 1;
      }
    }

    for (int i = 0; i < 5; i++) {
      setState(() {
        grid[row][i].flipping = true;
      });

      await Future.delayed(const Duration(milliseconds: 180));

      setState(() {
        final l = guess[i];

        if (l == answer[i]) {
          grid[row][i].color = Colors.green;
        } else if (freq[l] != null && freq[l]! > 0) {
          grid[row][i].color = Colors.orange;
          freq[l] = freq[l]! - 1;
        } else {
          grid[row][i].color = Colors.grey.shade800;
          if (!answer.contains(l)) {
            disabledKeys.add(l);
          }
        }

        grid[row][i].flipping = false;
      });

      await Future.delayed(const Duration(milliseconds: 80));
    }

    row++;
    col = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121213),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 30,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (_, i) {
                  final r = i ~/ 5;
                  final c = i % 5;
                  final tile = grid[r][c];
                  return WordTile(
                    letter: tile.letter,
                    color: tile.color,
                    flipping: tile.flipping,
                  );
                },
              ),
            ),

            const Spacer(),

            WordKeyboard(
              onKey: onKey,
              onEnter: submit,
              onBackspace: backspace,
              disabledKeys: disabledKeys,
            ),
          ],
        ),
      ),
    );
  }
}
