import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late bool isPlayer1Turn;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ''));
      isPlayer1Turn = true;
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '') {
      setState(() {
        board[row][col] = isPlayer1Turn ? 'X' : 'O';
        isPlayer1Turn = !isPlayer1Turn;
      });

      if (checkWinner()) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Game Over',
                style: TextStyle(color: Colors.red),
              ),
              content: Text(
                '${isPlayer1Turn ? 'Player 2' : 'Player 1'} wins!',
                style: TextStyle(
                    color: Color.fromARGB(255, 18, 128, 75),
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: Text(
                    'Play Again',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 7, 164, 255)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                ),
              ],
            );
          },
        );
      } else if (board.every((row) => row.every((cell) => cell != ''))) {
        // The game is a draw
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text(
                'It\'s a draw!',
                style: TextStyle(color: Colors.red),
              ),
              actions: <Widget>[
                OutlinedButton(
                  child: Text('Play Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool checkWinner() {
    // Check rows, columns, and diagonals for a winner
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != '' &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        return true; // Row winner
      }
      if (board[0][i] != '' &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        return true; // Column winner
      }
    }
    if (board[0][0] != '' &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return true; // Diagonal winner
    }
    if (board[0][2] != '' &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return true; // Diagonal winner
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe By Adham'),
        centerTitle: true,
        backgroundColor:Colors.blue ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int j = 0; j < 3; j++)
                    GestureDetector(
                      onTap: () => makeMove(i, j),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            board[i][j],
                            style: TextStyle(
                              fontSize: 44.0,
                              color: board[i][j] == 'X'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}
