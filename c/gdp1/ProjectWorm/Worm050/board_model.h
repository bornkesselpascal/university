// A simple variant of the game Snake
//
// Used for teaching in classes
//
// Author:
// Franz Regensburger
// Ingolstadt University of Applied Sciences
// (C) 2011
//
// The board model

#ifndef _BOARD_MODEL_H
#define _BOARD_MODEL_H

#include <curses.h>
#include "worm.h"

// Positions on the board
struct pos {
        int y;    // y-coordinate (row)
        int x;    // x-coordinate (column)
};

// Placing and removing items from the game board
// Check boundaries of game board
extern void placeItem(int y, int x, chtype symbol, enum ColorPairs color_pair);
extern int getLastRow();
extern int getLastCol();

#endif  // #define _BOARD_MODEL_H
