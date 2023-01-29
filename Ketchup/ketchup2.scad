$fn=16;

n = 19;
D = 100; // diameter of the plate over which the holder should be placed
BR = 8; // the radius of the base doughnut
ARM_R = 3; // radius of the arms/structure
H = 170; // height from zero to middle of top doughnut
RX = 42; // radius x direction at the top
RY = 32; // radius y direction at the top

module Segment(u,v,r1,r2) {
    hull() {
        translate(u)
            sphere(r1);
        translate(v)
            sphere(r2);
    }
}

module Doughnut(dough_r, inner_d) {
    rotate_extrude(convexity = 10, $fn=100)
        translate([inner_d + dough_r, 0, 0])
            circle(r = dough_r);
}

module BaseDoughnut() {
    Doughnut(BR,D);
}

module TopDoughnut(r) {
    for (i = [1:n]) {
        Segment([RX*cos((i-1)*360/n),RY*sin((i-1)*360/n),H],
                [RX*cos(i*360/n),RY*sin(i*360/n),H],r,r);
    }
}

module Arm(angle,d_angle,bottom_r,top_r) {
    for (i = [1:n]) {
        s = (i-1)/n;
        t = i/n;
        srs = top_r*s+bottom_r*(1-s); // segment radius for s
        srt = top_r*t+bottom_r*(1-t); // segment radius for t
        a = angle+d_angle*s;
        b = angle+d_angle*t;
        rxs = RX*s+(D+BR)*(1-s);
        rys = RY*s+(D+BR)*(1-s);
        rxt = RX*t+(D+BR)*(1-t);
        ryt = RY*t+(D+BR)*(1-t);
        Segment([rxs*cos(a),rys*sin(a),H*s],
                [rxt*cos(b),ryt*sin(b),H*t],srs,srt);
    }
}

module Curved(angle,d_angle,bottom_r,top_r) {
    for (i = [1:n]) {
        s = (i-1)/n;
        t = i/n;
        srs = top_r*s+bottom_r*(1-s); // segment radius for s
        srt = top_r*t+bottom_r*(1-t); // segment radius for t
        a = angle+d_angle*(1-cos(s*90));
        b = angle+d_angle*(1-cos(t*90));
        rxs = RX*s+(D+BR)*(1-s);
        rys = RY*s+(D+BR)*(1-s);
        rxt = RX*t+(D+BR)*(1-t);
        ryt = RY*t+(D+BR)*(1-t);
        Segment([rxs*cos(a),rys*sin(a),H*s],
                [rxt*cos(b),ryt*sin(b),H*t],srs,srt);
    }
}

module Curved2(angle,d_angle,bottom_r,top_r) {
    for (i = [1:n]) {
        s = (i-1)/n;
        t = i/n;
        srs = top_r*s+bottom_r*(1-s); // segment radius for s
        srt = top_r*t+bottom_r*(1-t); // segment radius for t
        a = angle+d_angle*(1-cos(s*180))/2;
        b = angle+d_angle*(1-cos(t*180))/2;
        rxs = RX*s+(D+BR)*(1-s);
        rys = RY*s+(D+BR)*(1-s);
        rxt = RX*t+(D+BR)*(1-t);
        ryt = RY*t+(D+BR)*(1-t);
        Segment([rxs*cos(a),rys*sin(a),H*s],
                [rxt*cos(b),ryt*sin(b),H*t],srs,srt);
    }
}

module ArmedHolder(k) {
    BaseDoughnut();
    TopDoughnut(ARM_R);
    for (i =[1:k]) {
        a = i*360/k;
        Arm(a,360/k,ARM_R,ARM_R);
        Arm(a,-360/k,ARM_R,ARM_R);
    }
}

module CurvedHolder(k) {
    BaseDoughnut();
    TopDoughnut(ARM_R);
    for (i =[1:k]) {
        a = i*360/k;
        Curved(a,360/k,ARM_R,ARM_R);
        Curved(a,-360/k,ARM_R,ARM_R);
    }
}

module TreeHolder(stems,branches,move,multiplier) {
    BaseDoughnut();
    //TopDoughnut(ARM_R);
    for (i=[1:stems]) {
        a = move + i*360/stems;
        d = multiplier * 360 / (stems * branches);
        for (j=[1:branches]) {
            Curved2(a,(j-(branches+1)/2)*d,BR,ARM_R);
        }
    }
}

intersection() {
    // ArmedHolder(8);
    // CurvedHolder(8);

    // TreeHolder(4,6,45);
    TreeHolder(7,6,0,2);

    // Arm(13,69);
    // Curved(13,69);

    // Segment([D,0,0],[-D,0,0],r);

    translate([0,0,H])
        cube([3*D,3*D,2*H], center=true);
}
