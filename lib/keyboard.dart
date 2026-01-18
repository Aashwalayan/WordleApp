import 'package:flutter/material.dart';

class WordKeyboard extends StatelessWidget {
  final Function(String) onKey;
  final VoidCallback onEnter;
  final VoidCallback onBackspace;
  final Set<String> disabledKeys;

  const WordKeyboard({
    super.key,
    required this.onKey,
    required this.onEnter,
    required this.onBackspace,
    required this.disabledKeys,
  });

  static const row1 = "QWERTYUIOP";
  static const row2 = "ASDFGHJKL";
  static const row3 = "ZXCVBNM";

  Widget buildKey(String k, double size) {
    final disabled = disabledKeys.contains(k);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: GestureDetector(
        onTap: () => onKey(k),
        child: Container(
          width: size,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: disabled ? Colors.grey.shade800 : Colors.grey.shade600,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            k,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final usableWidth = screenWidth * 0.88;

    final keySize = usableWidth / 10;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row1.split('').map((k) => buildKey(k, keySize)).toList(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row2.split('').map((k) => buildKey(k, keySize)).toList(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: keySize * 1.5,
                height: 46,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: GestureDetector(
                    onTap: onEnter,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "ENTER",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
                ),
              ),

              ...row3.split('').map((k) => buildKey(k, keySize)),

              SizedBox(
                width: keySize * 1.5,
                height: 46,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: GestureDetector(
                    onTap: onBackspace,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade700,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.backspace,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
