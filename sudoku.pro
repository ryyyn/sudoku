%% Solves sudoku by specifying the data range, listing the constraints, and then attepting to fill it in with label.
%% Works on 9x9 sudoku.

%% use routines from the Constraint Logic Programming over Finite Domains library
:- use_module(library('clpfd')).

%% Execute program with:  "solve('[path\\folder\\etc\\]filename.txt')."

solve(File) :-
	see(File),		% open file
	write(trying_file(File)),nl,nl,
	read(Board),
	seen,                   % close file
	time(sudoku(Board)),
	pretty_sudo_print(Board),nl.

pretty_sudo_print(Board) :-
	Board = [R1,R2,R3,R4,R5,R6,R7,R8,R9],
	nl,nl,
	printsudorow(R1),
	printsudorow(R2),
	printsudorow(R3),
	write('-------+-------+-------'), nl,
	printsudorow(R4),
	printsudorow(R5),
	printsudorow(R6),
	write('-------+-------+-------'), nl,
	printsudorow(R7),
	printsudorow(R8),
	printsudorow(R9).

printsudorow(Row) :-
	Row = [C1,C2,C3,C4,C5,C6,C7,C8,C9],
	write(' '),
	write(C1), write(' '),
	write(C2), write(' '),
	write(C3), write(' '), write('|'), write(' '),
	write(C4), write(' '),
	write(C5), write(' '),
	write(C6), write(' '), write('|'), write(' '),
	write(C7), write(' '),
	write(C8), write(' '),
	write(C9), write(' '), nl.

sudoku(Board) :-
	Board = [R1,R2,R3,R4,R5,R6,R7,R8,R9],
	R1 ins 1..9,
	R2 ins 1..9,
	R3 ins 1..9,
	R4 ins 1..9,
	R5 ins 1..9,
	R6 ins 1..9,
	R7 ins 1..9,
	R8 ins 1..9,
	R9 ins 1..9,
	maplist(all_different, Board),
	transpose(Board, Cols),
	maplist(all_different, Cols),
	subgrids(R1,R2,R3),
	subgrids(R4,R5,R6),
	subgrids(R7,R8,R9),
	maplist(label, Board).

subgrids([A,B,C,D,E,F,G,H,I],[J,K,L,M,N,O,P,Q,R],[S,T,U,V,W,X,Y,Z,AA]) :-
	all_different([A,B,C,J,K,L,S,T,U]),
	all_different([D,E,F,M,N,O,V,W,X]),
	all_different([G,H,I,P,Q,R,Y,Z,AA]).
