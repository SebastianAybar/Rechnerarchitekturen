

.text
main:
# MMIO Adressen
lui $t5, 0xFFFF 	# MSB des Tastaturstatusregister
ori $t5, $t5, 0x0000 	# LSB des Wertes muss 0 sein
addi $t6, $t5, 4	# Tastaturdatenregister 0xFFFF0004
addi $t7, $t5, 12	# Dispolay-Datenregister 0xFFFF000C


loop:
# Warten auf Tastatureingabe
poll:
lw $t0, 0($t5) # Wir holen uns den Wert aus dem Tastaturstatusregister
andi $t0, $t0, 1 # Wir prüfen den Wert
beq $t0, $zero, poll # Wenn der Wert 0 ist wiederholen wir die Schleife


# Sobald ein Wert vorhanden ist
lw $t1, 0($t6)            # Lade den Wert in $t1

# Prüfung auf Kleinbuchstaben
addi $t2, $zero, 97	# Wir erstellen die 97 zum vergleichen
addi $t3, $zero, 122    # Wir erstellen die 122 zum vergleichen
slt $t4, $t1, $t2	# Wenn t1 < 97 kann es schon kein lowercase mehr sein und dann steht 0 in t4
bne $t4, $zero, not_lower_case # Wenn t4 == 1 dann springen wir zur Ausgabe
slt $t4,  $t3, $t1	# Wenn t1 > 122 kann es auch kein lowercase sein und in t4 steht 1
bne $t4, $zero, not_lower_case # Wenn t4 == 1 dann springen wir zur Ausgabe

# Wenn wir hier ankommen war es ein Kleinbuchstabe und wir müssen umwandeln
addi $t1, $t1, -32	#-32 wegen ASC2

not_lower_case:
sw $t1, 0($t7)	# Wir schreiben ins Display-Datenregister

# Schleife wiederholen für nächstes Zeichen von der Tastatur
j loop














