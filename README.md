# chess_ruby

Chess needs:

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

Save game!
Check king
Game over
    Checkmate
    Surrender
    

