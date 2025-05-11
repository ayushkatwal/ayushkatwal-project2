:- module(maze_solver, [find_exit/2]).
 
% find a path from start to finish
find_exit(Maze, Path) :-
    nonvar(Path), !,
    validate_maze(Maze),
    find_start(Maze, StartingRow, StartingCol),
    follow_path(Maze, Path, StartingRow, StartingCol, _, _).

find_exit(Maze, Path) :-
    validate_maze(Maze),
    find_start(Maze, StartingRow, StartingCol),
    explore_maze(Maze, Path, StartingRow, StartingCol).

% validate the maze and make sure there is only one starting spot
validate_maze(Maze) :-
    is_list(Maze),
    Maze = [RowOne|_],
    is_list(RowOne),
    length(RowOne, Cols),
    maplist(validate_row(Cols), Maze),
    findall(coord(R, C), (nth0(R, Maze, Row), nth0(C, Row, s)), L),
    length(L, 1).

validate_row(Cols, Row) :-
    is_list(Row),
    length(Row, Cols),
    maplist(valid_cell, Row).

valid_cell(f).
valid_cell(w).
valid_cell(s).
valid_cell(e).

% find the starting position in the maze
find_start(Maze, Row, Col) :-
    nth0(Row, Maze, MazeRow),
    nth0(Col, MazeRow, s).

% follow a path to look for exit
follow_path(Maze, [], Row, Col, Row, Col) :-
    cell_content(Maze, Row, Col, e).

follow_path(Maze, [Action|Actions], CurrRow, CurrCol, EndRow, EndCol) :-
    move(Action, CurrRow, CurrCol, NextRow, NextCol),
    valid_move(Maze, NextRow, NextCol),
    follow_path(Maze, Actions, NextRow, NextCol, EndRow, EndCol).

% explore the maze using dfs approach looking for an exit
explore_maze(Maze, Path, Row, Col) :-
    explore_maze(Maze, [], Path, Row, Col).

explore_maze(Maze, _, [], Row, Col) :-
    cell_content(Maze, Row, Col, e).

explore_maze(Maze, Visited, [Action|Path], CurrRow, CurrCol) :-
    move(Action, CurrRow, CurrCol, NextRow, NextCol),
    valid_move(Maze, NextRow, NextCol),
    \+ member(coord(NextRow, NextCol), Visited),
    explore_maze(Maze, [coord(CurrRow, CurrCol)|Visited], Path, NextRow, NextCol).

% get cell contents 
cell_content(Maze, Row, Col, Content) :-
    nth0(Row, Maze, MazeRow),
    nth0(Col, MazeRow, Content).

% move predicates
valid_move(Maze, Row, Col) :-
    length(Maze, Rows),
    RowsMax is Rows - 1,
    Maze = [FirstRow|_],
    length(FirstRow, Cols),
    ColsMax is Cols - 1,
    between(0, RowsMax, Row),
    between(0, ColsMax, Col),
    cell_content(Maze, Row, Col, Content),
    Content \= w.

% move definitions
move(left, Row, Col, Row, NewCol) :- NewCol is Col - 1.
move(right, Row, Col, Row, NewCol) :- NewCol is Col + 1.
move(up, Row, Col, NewRow, Col) :- NewRow is Row - 1.
move(down, Row, Col, NewRow, Col) :- NewRow is Row + 1.

