$fn=60;

// konstanter / parametre

TYKKING = 3; // hvor tykk er lista rundt trelista
H_NEDE = 22; // høyde under "streken"
H_OPPE = 22; // høyde over "streken"
INDRE_VIDDE = 146;
EKSTRA_TYKKING = 6;
TRE_VIDDE = 15.8;
TRE_DYBDE = 44.5;
EKSTRA_INN_BAK = TRE_VIDDE-1.5;
EXTRA_R = 0.6;

SKRUE_D=2.5;
HODE_D=6;
HODE_H=3;
HODE_INN=1.1;

// avledede verdier
FULL_VIDDE = INDRE_VIDDE + 2 * (TYKKING + TRE_VIDDE);
SKRU_BASE_VIDDE = (INDRE_VIDDE + FULL_VIDDE) * 0.5;

module half_rounded(a,b,h,r) {
    intersection() {
        hull() {
            translate([a/2,b/2,h]) sphere(r);
            translate([a/2,-b/2,h]) sphere(r);
            translate([-a/2,-b/2,h]) sphere(r);
            translate([-a/2,b/2,h]) sphere(r);
            translate([a/2,b/2,-h]) sphere(r);
            translate([a/2,-b/2,-h]) sphere(r);
            translate([-a/2,-b/2,-h]) sphere(r);
            translate([-a/2,b/2,-h]) sphere(r);
        }
        translate([0,0,h]) cube([2*a,2*b,2*h],center=true);
    }
}

module ny() {
    Z_JU = (H_OPPE - H_NEDE)/2;
    Z_TOT = H_NEDE + H_OPPE;
    // den største lista
    translate([0,0,Z_JU])
        rotate([-90,0,0])
            half_rounded(FULL_VIDDE, Z_TOT, TYKKING, EXTRA_R);
    // den boksen som går inni, under
    translate([-INDRE_VIDDE/2,-EKSTRA_TYKKING,-H_NEDE-EXTRA_R])
        cube([INDRE_VIDDE,TYKKING+EKSTRA_TYKKING,H_NEDE+EXTRA_R]);
    // en bit på siden, positivt på x-aksen
    DX=INDRE_VIDDE/2+TRE_VIDDE;
    DY=-TRE_DYBDE/2;
    DXB=DX+TYKKING/2-EKSTRA_INN_BAK/2;
    DYBDE=2*TYKKING+TRE_DYBDE;
    translate([DX,DY,Z_JU])
        rotate([0,90,0])
            half_rounded(H_NEDE + H_OPPE, DYBDE, TYKKING, EXTRA_R);
    // den lille biten bak
    translate([DXB,-TRE_DYBDE,Z_JU])
        rotate([90,0,0])
            half_rounded(TYKKING + EKSTRA_INN_BAK, Z_TOT, TYKKING, EXTRA_R);
    // en bit på den andre siden, negativt på x-aksen
    translate([-DX,DY,Z_JU])
        rotate([0,-90,0])
            half_rounded(Z_TOT, DYBDE, TYKKING, EXTRA_R);
    // den lille biten bak på den andre siden
    translate([-DXB,-TRE_DYBDE,Z_JU])
        rotate([90,0,0])
            half_rounded(TYKKING + EKSTRA_INN_BAK, Z_TOT, TYKKING, EXTRA_R);
}

module gammel() {
    translate([-EKSTRA_TYKKING,-INDRE_VIDDE/2,-H_NEDE])
        cube([TYKKING+EKSTRA_TYKKING,INDRE_VIDDE,H_NEDE]);
    translate([0,-FULL_VIDDE/2,-H_NEDE])
        cube([TYKKING, FULL_VIDDE,H_NEDE+H_OPPE]);
    translate([-TRE_DYBDE-TYKKING,INDRE_VIDDE/2+TRE_VIDDE,-H_NEDE])
        cube([TRE_DYBDE+2*TYKKING,TYKKING,H_NEDE+H_OPPE]);
    translate([-TRE_DYBDE-TYKKING,-INDRE_VIDDE/2-TRE_VIDDE-TYKKING,-H_NEDE])
        cube([TRE_DYBDE+2*TYKKING,TYKKING,H_NEDE+H_OPPE]);
}

module skrue() {
    HULL_H=2*(TYKKING+EKSTRA_TYKKING);
    translate([0,TYKKING-HODE_INN,0]) {
        rotate([90,0,0])
            cylinder(h=HULL_H,r=SKRUE_D/2,center=true);
        rotate([-90,0,0])
            cylinder(h=HULL_H,r=HODE_D/2,center=false);
        rotate([90,0,0])
            cylinder(h=HODE_H,r1=HODE_D/2, r2=SKRUE_D/2,center=false);
    }
}

module ny_med_hull() {
    difference() {
        ny();
        translate([SKRU_BASE_VIDDE/3,0,-H_NEDE/3])
            skrue();
        translate([-SKRU_BASE_VIDDE/3,0,-H_NEDE/3])
            skrue();
    }
}

translate([0,0,H_NEDE])
    ny_med_hull();
