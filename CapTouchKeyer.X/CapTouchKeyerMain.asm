
#include <p16f610.inc>

    ;config
    __CONFIG(_INTOSCIO & _WDTE_OFF & _PWRTE_ON & _MCLRE_OFF & _CP_OFF & _IOSCFS_4MHZ &_BOREN_OFF)
    ERRORLEVEL	-302		; Remove message about using proper bank

;Defines

;Cblock
    Cblock 0x40

;Declaring variables
	W_TEMP
	STATUS_TEMP
	DelayCounter1		;Declaration of variable from Gibbs' code.
	DelayCounter2		;Declaration of variable from Gibbs' code.
	DelayCounter3		;Declaration of variable from Gibbs' code.

	endc
;End of Cblock

	ORG	0x00
	GOTO 	Setup

;Interrupt
	ORG 		0x04            ;From Microchip
	MOVWF 	W_TEMP              ;Copy W to TEMP register
	SWAPF 	STATUS,W            ;Swap status to be saved into W
	CLRF 	STATUS              ;bank 0, regardless of current bank, Clears IRP,RP1,RP0
	MOVWF 	STATUS_TEMP         ;Save status to bank zero STATUS_TEMP register

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;ISR HERE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	SWAPF 	STATUS_TEMP,W       ;Swap STATUS_TEMP register into W
								;(sets bank to original state)
								;returning context to original and returning from interrupt
	MOVWF	STATUS              ;Move W into Status register
	SWAPF 	W_TEMP,F            ;Swap W_TEMP
	SWAPF 	W_TEMP,W            ;Swap W_TEMP into W
	RETFIE                      ;interrupt is finished
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

end
