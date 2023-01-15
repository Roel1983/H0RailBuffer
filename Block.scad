include <Config.inc>
include <Constants.inc>

use <MirrorCopy.scad>

Block(
    is_printable = true
);

module Block(
    is_printable = false
) {
    if(is_printable) {
        Part();
    } else {
        translate([0, -3, leg_height]) rotate(90, VEC_X) {
            Part();
        }
    }
    module Part() {
        difference() {
            linear_extrude(block_size[Y]) {
                square([block_size[X], block_size[Z]], true);
            }
            mirror_copy(VEC_X) {
                x1 = 3 * LAYER;
                x2 = foot_width[0] / 2 + plate_size[0];
                translate([
                    (rail_distance + x1 - x2) / 2,
                    0
                ]) {
                    cube([
                        x1 + x2 + 2 * TOL,
                        block_size[2] - 4 * NOZZLE,
                        block_size[Y]], true);
                }
            }
        }
    }
}