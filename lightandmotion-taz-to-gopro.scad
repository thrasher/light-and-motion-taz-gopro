// Light & Motion Taz to GoPro mount

$fs = 0.1; // mm per facet in cylinder
$fa = 5; // degrees per facet in cylinder
$fn = 100;

bolt_height = 0.375; // M3-.50x12, 2mm hex bolt
bolt_dia = 0.265; // washer diameter for the bolt

gopro_width=0.368;
gpro_fin_width = 0.116;
gpro_dia = 0.6;

module gopromount() {
    translate([0, -gpro_dia/2, 0])
    difference() {
        union() {
            translate([0,0,-gopro_width/2]) {
                cylinder(d = gpro_dia, h = gpro_fin_width);
                translate([-gpro_dia/2,0,0]) cube([gpro_dia, gpro_dia/2, gpro_fin_width]);
            }
            translate([0,0, gopro_width/2 - gpro_fin_width]) {
               cylinder(d = gpro_dia, h = gpro_fin_width);
               translate([-gpro_dia/2,0,0]) cube([gpro_dia, gpro_dia/2, gpro_fin_width]);
            }
        }
        translate([0, 0, -0.5]) cylinder(d = 0.210, h = 1);
    }
}


rotate([0, 180, 0]) translate([0, 0, 0])difference() {
    union() {
        rotate([90, 0, 0]) translate([.5, 0, 0]) gopromount();
        cube([gopro_width,gopro_width,.1], center=true);
        translate([-.275, -.25, 0]) {
            minkowski() {
                cube([1, .5, .1]);
                cylinder(d = .15, h = 0.01);
            }
        }
        translate([0, 0, -bolt_height + .2]) cylinder(d = 0.48, h = bolt_height);
        translate([0, 0, -bolt_height + .2]) cylinder(d = 0.65, h = bolt_height - 0.05);
    }
    translate([0, 0, -1]) cylinder(d = .125, h = 2);
    translate([0, 0, .2-.12]) cylinder(d = .34, h = 1);
    translate([0, 0, -bolt_height + .2 - bolt_height]) cylinder(d=bolt_dia, h=bolt_height); // screw head
    rotate([90, 0, 0]) translate([.5, -gpro_dia/2, -gopro_width/2-.1]) {
        cylinder(d = gpro_dia, h = .1);
        translate([0, 0, .1+gpro_fin_width]) cylinder(d = gpro_dia, h = gopro_width-2*gpro_fin_width);
        translate([0, 0, .1+gopro_width]) cylinder(d = gpro_dia, h = .1);
    }
    
}
