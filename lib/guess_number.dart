// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:guess_number3/Game.dart';

void main() {
  Game guessTheNumber = Game();
  guessTheNumber.playAgainMode = true;

  guessTheNumber.startGame();
}