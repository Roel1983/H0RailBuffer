front_leg_tilt = 3;
back_leg_tilt = 12;
leg_height = 12;
foot_height = 2;
foot_bottom = 2;
leg_width = [2.5, 2.5];
foot_width = [3.5, 3.5];
block_distance = 3;
rail_width = 1.5;
rail_distance = 16.9;
block_size = [30,2.5,5.5];
joint_size = 4.5;
indent = 1;

bevel = 0.2;

BIAS = 0.01;
INV = 100;
TOL = 0.15;

X_AXIS = [1, 0, 0];
Y_AXIS = [0, 1, 0];

buffer();



!block();
*union() {
    intersection() {
        a_frame();
        translate([INV/2,0,0]) cube(INV, true);
    }
    for(y=[-front_leg_tilt-3, back_leg_tilt+1.5]) translate([0,y,-1.7]) {
        cube([leg_width[0]/3,4,.41]);
    }
}

module buffer() {
    for(x=[-rail_distance / 2, rail_distance / 2]) translate([x,0,0]) {
      a_frame();
    }
    translate([0,-4,leg_height]) block();
}

module block() {
    translate([0,0,bevel]) linear_extrude(block_size[2] -bevel) block_2d();
    linear_extrude(block_size[2] -bevel) offset(-bevel) block_2d();
}

module block_2d() {
    difference() {
        square([block_size[0], block_size[1]], true);
        *for(x=[-rail_distance / 2, rail_distance / 2]) translate([x,block_size[1]/2,0]) {
            square([leg_width[0] + 2*TOL, 1], true);
        }
    }
}

module a_frame() {
    leg(front_leg_tilt);
    leg(-back_leg_tilt);
    translate([0,0, leg_height]) {
        joint();
    }
}

module joint() {
    front_leg_angle = atan(front_leg_tilt / leg_height);
    back_leg_angle = atan(back_leg_tilt / leg_height);
    
    rotate(-90, Y_AXIS)linear_extrude(foot_width[0], center = true) {
        intersection() {
            hull() {
                rotate(front_leg_angle) translate([-joint_size / 2, 0]) {
                    square([joint_size, foot_width[1]], true);
                }
                rotate(-back_leg_angle) {
                    square([2 * joint_size, foot_width[1]], true);
                }
            }
            translate([3.3,-3]) {
                rotate(90) square(INV);
            }
        }
    }
}

module leg(tilt) {
    angle = atan(tilt / (leg_height - foot_height));
    leg_length = sqrt(pow(tilt, 2) + pow((leg_height - foot_height), 2));
    foot_length = (foot_height + foot_bottom) / cos(angle);
 
    translate([0, -tilt, foot_height]) {
        difference() {
            rotate(-angle, X_AXIS) {
                translate([0,0,leg_length/2]) {
                    cube([leg_width[0], leg_width[1] - 2*indent, leg_length + 2*BIAS], true);
                    copy_mirror() translate([leg_width[0] / 3, 0]) {
                        cube([leg_width[0] / 3, leg_width[1], leg_length + 2*BIAS], true);
                    }
                }
                intersection() {
                    translate([0, 0, -foot_length / 2]) {
                        cube(concat(foot_width, foot_length), true);
                    }
                    rotate(angle, X_AXIS) {
                        translate([0, 0, -foot_height - foot_bottom]) {
                            translate([0, 0, INV / 2]) cube(INV, true);
                        }
                    }
                }
            }
            translate([0,0, -foot_bottom-foot_height]) {
                cube([rail_width, leg_width[1] + abs(tilt*2) + BIAS, foot_bottom * 2] , true);
            }
        }
    }
}

module copy_mirror(vec = undef) {
    children();
    mirror(vec) children();
}

//function vec_cat()