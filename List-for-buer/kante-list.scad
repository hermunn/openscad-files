$fn=60;

// konstanter / parametre

TYKKING = 3; // hvor tykk er lista rundt trelista
H_NEDE = 15; // høyde under "streken"
H_OPPE = 12; // høyde over "streken"
INDRE_VIDDE = 148;
EKSTRA_TYKKING = 5;
TRE_VIDDE = 6;
TRE_DYBDE = 24;
EKSTRA_INN_BAK = 4;

// avledede verdier
FULL_VIDDE = INDRE_VIDDE + 2 * (TYKKING + TRE_VIDDE);

translate([-EKSTRA_TYKKING,-INDRE_VIDDE/2,-H_NEDE])
    cube([TYKKING+EKSTRA_TYKKING,INDRE_VIDDE,H_NEDE]);
translate([0,-FULL_VIDDE/2,-H_NEDE])
    cube([TYKKING, FULL_VIDDE,H_NEDE+H_OPPE]);
translate([-TRE_DYBDE-TYKKING,INDRE_VIDDE/2+TRE_VIDDE,-H_NEDE])
    cube([TRE_DYBDE+2*TYKKING,TYKKING,H_NEDE+H_OPPE]);
translate([-TRE_DYBDE-TYKKING,-INDRE_VIDDE/2-TRE_VIDDE-TYKKING,-H_NEDE])
    cube([TRE_DYBDE+2*TYKKING,TYKKING,H_NEDE+H_OPPE]);
