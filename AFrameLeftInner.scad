include <Constants.inc>
use <AFrameSide.scad>

AFrameLeftInner(
    is_printable = true
);

module AFrameLeftInner(
    is_printable = false
) {
    mirror(VEC_X) {
        if(is_printable) {
            echo("Detect thin walls: true");
            rotate(-90, VEC_Y) AFrameSide("inner", add_print_support = true);
        } else {
            AFrameSide("inner");
        }
    }
}