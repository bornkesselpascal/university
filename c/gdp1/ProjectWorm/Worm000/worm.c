// A simple variant of the game Snake
//
// Used for teaching in classes
//
// Author:
// Franz Regensburger
// Ingolstadt University of Applied Sciences
// (C) 2011
//

#include <curses.h>
#include <string.h>

// ********************************************************************************************
// Constants, data structures
// ********************************************************************************************

// Result codes of functions
#define RES_OK 0
#define RES_FAILED 1







// *********************************************
// Standard curses initialization and cleanup
// *********************************************

// Initialize application with respect to curses settings
void initializeCursesApplication() {
    initscr(); // Initialize the curses screen –  Curses-Modus starten

    // Note:
    // The call to initscr() defines various global variables of the curses framework.
    // stdscr, LINES, COLS, TRUE, FALSE

    noecho();  // Characters typed are not echoed  – Unterdückt die Anzeige der eingegebenen Zeichen
    cbreak();  // No buffering of stdin – Deaktiviert das Puffern, alle Eingaben stehen direkt zu Verfügung
    nonl();    // Do not translate 'return key' on keyboard to newline character – Interpretiert RETURN nicht mehr als neue Zeile (\n)
    keypad(stdscr, TRUE); // Enable the keypad – Aktiviert das Keypad für aktuelles Fenster, ermöglicht (da TRUE) eine Auswertung der Funktionstasten
    curs_set(0);          // Make cursor invisible
    // Begin in non-single-step mode (getch will not block)
    nodelay(stdscr, TRUE);  // make getch to be a non-blocking call
}





// Reset display to normale state and terminate curses application
void cleanupCursesApp(void)
{
    standend();   // Turn off all attributes 
    refresh();    // Write changes to terminal
    curs_set(1);  // Set cursor state to normal visibility
    endwin();     // Terminate curses application
}





// ********************************************************************************************
// MAIN
// ********************************************************************************************

int main(void) {
    int res_code;         // Result code from functions
    char* message_template = "Das Fenster hat xxx Zeilen und yyy Spalten";
    int msg_len;
    int min_rows = 3;

    // SCHRITT 01
    initializeCursesApplication();


    // SCHRITT 02
    msg_len = strlen(message_template);


    // SCHRITT 03

    // Maximal LINES and COLS are set by curses for the current window size.
    // Check if the window is large enough to display our message

    if ( LINES < min_rows       || COLS < msg_len     ) {
        
        // SCHRITT 04
        cleanupCursesApp();


        // SCHRITT 05

        // Print a conventional error message via printf.
        // Note: this only work after the call to  cleanupCursesApp();
        printf("Das Fenster ist zu klein: wir brauchen mindestens %dx%d\n",msg_len, min_rows);

        // Set the result code to report the error
        res_code = RES_FAILED;
    } else {

        // SCHIRTT 6 – Center output
        int mid_row = LINES/2;
        int start_col = (COLS - msg_len)/2;

        // Write letter A to the top    left  corner of our display
        move(0,0);          // Move to position
        addch('A');         // Put character there

        // Write letter B to the top    right corner of our display
        // Use combination of move() and addch() functions
        mvaddch(0,(COLS-1),'B');
        // Write letter C to the bottom right corner of our display
        mvaddch((LINES-1),(COLS-1),'C');
        // Write letter D to the bottom left  corner of our display
        mvaddch((LINES-1),0,'D');
 

        // Write our message centered onto the display
        mvprintw(mid_row, start_col,"Das Fenster hat %3d Zeilen und %3d Spalten",LINES, COLS);

        // Refresh the screen in order to show all changes on the screen
        refresh();
        
        // Wait for user to press a key
        nodelay(stdscr, FALSE);   // make getch to be a blocking call
        getch();

        // Set the result code to report success
        res_code = RES_OK;

        // Cleanup special curses settings and restore the normal terminal functionality
        cleanupCursesApp();
    }
    return res_code;
}
