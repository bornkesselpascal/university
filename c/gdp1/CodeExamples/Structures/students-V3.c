// Zweck dieser Demo:
// Zeige, wie Strukturvariablen per Value via Stack an Funktionen
// uebergeben werden.
// Im gdb den erzeugten Assemblercode betrachten.
//
// (gdb) set disassembly-flavor intel
// (gdb) disassemble /m main
// 
// 50        druckeStudent(lt);
//    0x0804856a <+101>:   mov    edx,esp         # aktueller SP nach edx laden
//    0x0804856c <+103>:   lea    ebx,[esp+0xe4]  # Start der Variablen lt
//    0x08048573 <+110>:   mov    eax,0x1a        # Laenge Struktur in DWORDS 26*4 = 104Byte
//    0x08048578 <+115>:   mov    edi,edx         # Ziel auf Stack nach edi laden
//    0x0804857a <+117>:   mov    esi,ebx         # Quelle auf Stack nach esi laden
//    0x0804857c <+119>:   mov    ecx,eax         # Anzahl DWORDs nach ecx laden
//    0x0804857e <+121>:   rep movs DWORD PTR es:[edi],DWORD PTR ds:[esi] # 26 * 4 Byte kopieren
//    0x08048580 <+123>:   call   0x804846d <druckeStudent>  # Aufruf druckeStudent
// 

#include <stdio.h>

#define OK 0
#define FAILURE 1

struct adresse {
  // Alle char[] sind '\0' terminierte Strings.
  char strasse[20];
  char hausnummer[5];
  int  postleitzahl;
  char stadt[20];
};

struct student {
  char matrikelnummer[6]; // char[] wegen fuehrender Nullen in Matrikelnummern
  char studiengang[5];
  char nachname[20];
  char vorname[20];
  struct adresse wohnort; // Komponententyp ist selbst eine Struktur!
};

void druckeStudent(struct student s) {
  // Kopfzeile
  printf("\n%6s%5s%21s%21s%21s%6s%6s%20s\n",
      "MatNr","StGg","Nachname","Vorname","Strasse","HNr","PLZ","Stadt");
  printf("%6s%5s%21s%21s%21s%6s%6d%20s\n",
      s.matrikelnummer,
      s.studiengang,
      s.nachname,
      s.vorname,
      s.wohnort.strasse,
      s.wohnort.hausnummer,
      s.wohnort.postleitzahl,
      s.wohnort.stadt
      );
}

int main(void) {
  // Explizite Initialisierung von Strukturen erfolgt analog zur Initialisierung
  // von Arrays ueber {...}.
  struct student mm = 
  {"00001", "IB", "Munter","Monika",{"Jam Alley"   ,"2"   ,73210,"Gotham City"}};
  struct student lt = 
  {"00002", "IB", "Tragel","Lars"  ,{"Komaweg"     ,"4"   ,98765,"Bruchtal"}};

  druckeStudent(mm);
  druckeStudent(lt);
  return OK;
}
