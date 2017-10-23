:-module('ai3',[chooseMove3/4]).
:-use_module([library(lists),io,fill,end,utils,ai1]).

%    A  B  C  D  E  F  G  H
% 1 20 -3 11  8  8 11 -3 20
% 2 -3 -7 -4  1  1 -4 -7 -3
% 3 11 -4  2  2  2  2 -4 11
% 4  8  1  2 -3 -3  2  1  8
% 5  8  1  2 -3 -3  2  1  8
% 6 11 -4  2  2  2  2 -4 11
% 7 -3 -7 -4  1  1 -4 -7 -3
% 8 20 -3 11  8  8 11 -3 20

mobility(Player,Board,N):-
    count(getLegalMove(Player,_,_,Board),N).

isValueBoard(VBoard):-
    VBoard = [[20,-3,11, 8, 8,11,-3,20],
              [-3,-7,-4, 1, 1,-4,-7,-3],
              [11,-4, 2, 2, 2, 2,-4,11],
              [ 8, 1, 2,-3,-3, 2, 1, 8],
              [ 8, 1, 2,-3,-3, 2, 1, 8],
              [11,-4, 2, 2, 2, 2,-4,11],
              [-3,-7,-4, 1, 1,-4,-7,-3],
              [20,-3,11, 8, 8,11,-3,20]].

getPositionValue(X,Y,V):-
    isValueBoard(VBoard),
    getVal(VBoard,X,Y,V).

evalPosition(Player,Board,E):-
    isValueBoard(VBoard),
    dot2(Board,VBoard,R),
    (   Player =:= -1 -> E is -R;
    E is R).

evalCorner(Player,Board,E):-
    getVal(Board,0,0,V1),
    getVal(Board,0,7,V2),
    getVal(Board,7,0,V3),
    getVal(Board,7,7,V4),
    R is 25*(V1+V2+V3+V4),
    (   Player =:= -1 -> E is -R;
    E is R).

evalDanger(Player,Board,E):-
    getVal(Board,0,1,VP1),
    getVal(Board,0,6,VP2),
    getVal(Board,1,0,VP3),
    getVal(Board,1,7,VP4),
    getVal(Board,6,0,VP5),
    getVal(Board,6,7,VP6),
    getVal(Board,7,1,VP7),
    getVal(Board,7,6,VP8),
    getVal(Board,1,1,VS1),
    getVal(Board,1,6,VS2),
    getVal(Board,6,1,VS3),
    getVal(Board,6,6,VS4),
    R is -12.5*(VP1+VP2+VP3+VP4+VP5+VP6+VP7+VP8+2*VS1+2*VS2+2*VS3+2*VS4),
    (   Player =:= -1 -> E is -R;
    E is R).



chooseMove3(AI,X,Y,Board):-
    getLegalMove(AI,X,Y,Board),!.
