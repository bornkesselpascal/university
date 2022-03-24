// Hilfsfunktion, die unsigned int32 in Binärdarstellung umwandelt
char* uint32tobin(unsigned int value, char* buffer){
  // Annahme: sizeof(buffer*) = 32+1
  // Prüfe Vorzeichen von value

  buffer[32]='\0';
  int count;
  for(count=31; count >=0; count--){
    if (value & 0x1) {
      buffer[count]='1';
    } else {
      buffer[count]='0';
    }
    value >>= 1;  // Shift um ein Bit nach rechts
  }
  return buffer; // gib Pointer auf Anfang des Puffers zurück
}
