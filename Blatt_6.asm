.data
    prompt: .asciiz "Eingabe einer positiven Zahl n: "
    result: .asciiz "Fakultät ist: "

.text
.globl main

main:
    # Eingabeaufforderung ausgeben
    li $v0, 4
    la $a0, prompt
    syscall

    # Zahl n einlesen (syscall 5)
    li $v0, 5
    syscall
    move $a0, $v0 # n in $a0 speichern (Argument für Fakultaet)

    # Fakultät berechnen (rekursiv)
    jal Fakultaet # Jump to Fakultaet, save return address in $ra

    # Ergebnis ausgeben
    move $t0, $v0 # Ergebnis in $t0 sichern
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 1
    move $a0, $t0 # Fakultät ausgeben
    syscall

    # Programm beenden
    li $v0, 10
    syscall

Fakultaet:
    # Rekursive Fakultätsberechnung: n! = n * (n-1)!
    # Basisfall: if (n == 0) return 1;
    # Sonst: return n * Fakultaet(n-1)

    # Prolog: Stack anpassen ($ra und $a0 sichern)
    addi $sp, $sp, -8 # 2 Wörter (8 Bytes) Platz reservieren
    sw $ra, 4($sp)# Rücksprungadresse speichern
    sw $a0, 0($sp)# Argument n speichern

    # Basisfall (n == 0)?
    bne $a0, $zero, recursive_case
    li $v0, 1 # return 1 (0! = 1)
    addi $sp, $sp, 8 # Stack zurücksetzen
    jr $ra # Zurück zum Aufrufer

recursive_case:
    # Rekursiver Aufruf: Fakultaet(n-1)
    addi $a0, $a0, -1 # n = n - 1
    jal Fakultaet # rekursiver Aufruf

    # Nach Rückkehr: $v0 enthält (n-1)!
    lw $a0, 0($sp)# Originales n wiederherstellen
    mul $v0, $a0, $v0 # Ergebnis = n * (n-1)!

    # Epilog: Stack bereinigen
    lw $ra, 4($sp)# Rücksprungadresse laden
    addi $sp, $sp, 8 # Stack zurücksetzen
    jr $ra # Zurück zum Aufrufer