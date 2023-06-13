# chess_ruby

Chess needs:

Save game!
    seriliaze the board
    Add option to continue previous game

Computer player
    Choose random piece and move it somewhere


{A board with numeration
{The board needs to know its numeration

{6 types of pieces - with unique movement rules
Rook
    !!Castling
{Knihgt
{Bishop
King
    !!Casling
{Queen
{Pawn
    enpasse
{(Superclass = piece > class = piece_type > Class.Player > assigng color + location)

{each player needs the pieces in different color
{Player vs PC can choose color (and starting order)
{Player 1 OR human player pieces are on the bottom

Class Game
{white start
{"Choose a piece by entering its location (a1)"
{user enters location
{"Choose where to go" // maybe shows available locations
{IF valid move ELSE repromt
{moves the piece to a new location
{IF contains opponent piece - it gets deleted
{switch player



{Check king
{scan the board for the opposite king - get its location
[scan board for @current_player pieces - check if they have kings location in available location
[if no - return
[if yes - check for checkmate
    [get all the possible moves a king can make
    [each goes thrugh if in way of a diffe
[Game over
    [Checkmate
    [Surrender



    

