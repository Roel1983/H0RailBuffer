include <Config.inc>
include <Constants.inc>

translate([0, -20]) AFrameSide("inner");
translate([0,  20]) AFrameSide("outer");

module AFrameSide(
    type
) {
    assert(type == "inner" || type == "outer");
    
    Leg(front_leg_tilt);
    Leg(-back_leg_tilt);
    
    translate([0,0, leg_height]) {
        Joint();
    }
    
    module Leg(tilt) {
        angle = atan(tilt / (leg_height - foot_height));
        leg_length = sqrt(pow(tilt, 2) + pow((leg_height - foot_height), 2));
        foot_length = (foot_height + foot_bottom) / cos(angle);
     
        translate([0, -tilt, foot_height]) {
            difference() {
                rotate(-angle, VEC_X) {
                    translate([0,0,leg_length/2]) {
                        translate([leg_width[0] / 4, 0]) {
                            cube([
                                leg_width[0] / 2,
                                leg_width[1] - 2 * indent,
                                leg_length + 2*BIAS], true);
                        }
                        translate([leg_width[0] / 3, 0]) {
                            cube([leg_width[0] / 3, leg_width[1], leg_length + 2*BIAS], true);
                        }
                    }
                    intersection() {
                        translate([foot_width[X] / 4, 0, -foot_length / 2]) {
                            cube([
                                foot_width[X] / 2,
                                foot_width[Y],
                                foot_length],true);
                        }
                        rotate(angle, VEC_X) {
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
    
    module Joint() {
        front_leg_angle = atan(front_leg_tilt / leg_height);
        back_leg_angle = atan(back_leg_tilt / leg_height);
        
        mirror(VEC_X) {
            rotate(-90, VEC_Y) {
                linear_extrude(foot_width[0] / 2) {
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
                Plate();
            }
        }
        
        
        module Plate() {
            translate([0,-3]) {
                linear_extrude(
                    ((type == "outer") ? (
                        3 * LAYER
                    ) : (
                        foot_width[0] / 2 + plate_size[0]
                    ))
                ) {
                    translate([
                        -block_size[2] / 2 + NOZZLE * 2 + TOL,
                        -block_size[1] / 2 + TOL
                    ]) square([
                        block_size[2] - NOZZLE * 4 - 2 * TOL,
                        block_size[1] / 2 + plate_size[1] - TOL]);
                }
            }
        }
    }
}
