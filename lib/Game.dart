
import 'dart:math';
import 'dart:io';

class Game {

  var maxRandom;
  int? _answer;
  int _counter = 0;
  bool _playAgainMode = false;
  var _random;
  var _history = <int>[];

  Game([int maxRandom = 100]){
    _random = Random();
    this.maxRandom = maxRandom;
  }
  void prepareGame() {
    stdout.write('Enter a maximum number to random: ');

    var input = stdin.readLineSync();
    var maxRandom = int.tryParse(input!);
    if (maxRandom != null)
      this.maxRandom = maxRandom;

      _answer = _random.nextInt(this.maxRandom) + 1;
      _counter = 0;



    print('╔════════════════════════════════════════');
    print('║            GUESS THE NUMBER            ');
    print('╟────────────────────────────────────────');
  }

  void startGame() {
    prepareGame();

    // print(_answer);
    while(_counter < maxRandom) {
      bool isCorrectInput = _inputNumber();
      if(isCorrectInput) {
        wonGame();
        break;
      }
    }
    if(_playAgainMode && playAgain()){
      startGame();
    }
  }
  bool playAgain() {
    stdout.write('Play again? (Y/N): ');
    var isY = stdin.readLineSync()! ;


    if(isY.toUpperCase() == 'Y') {
      return true;
    } else if(isY.toUpperCase() == 'N') {
      exitGame();
      return false;
    }

    return playAgain();


  }
  void wonGame() {
    // add history
    addHistory(_counter);

    maxRandom = null;

    print('║                 THE END                ');
    print('╚════════════════════════════════════════');

  }
  void exitGame() {
    printHistory();
  }
  bool _inputNumber() {
    stdout.write('║ Guess the number between 1 and $maxRandom: ');
    var input = stdin.readLineSync();
    var guess = int.tryParse(input!);
    if (guess == null) {
      return _inputNumber();
    }
    _counter++;

    if (guess > _answer!) {
      print('║ ➜ $guess is TOO HIGH! ▲');
      print('╟────────────────────────────────────────');
    } else if (guess < _answer!) {
      print('║ ➜ $guess is TOO LOW! ▼');
      print('╟────────────────────────────────────────');
    } else {
      print('║ ➜ The number was $_answer');
      print('║ ➜ $guess is CORRECT ❤, total guesses: $_counter');
      print('╟────────────────────────────────────────');
      return true;
    }
    return false;
  }

  void printHistory() {
    int games = _history.length;
    String msg = "You've played $games games\n";

    for(int i=1;i<=_history.length;++i) {
      int guesses = _history[i-1];
      msg += '🚀 Game #$i: $guesses guesses\n';
    }

    print(msg);
  }
  void addHistory(int value) {
    _history.add(value);
  }
  set playAgainMode(bool value) {
    _playAgainMode = value;
  }

  bool get playAgainMode => _playAgainMode;
}