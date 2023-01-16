include <Constants.inc>
use <AFrameSide.scad>

AFrameRightOuter(
    is_printable = true
);

module AFrameRightOuter(
    is_printable = false
) {
    mirror(VEC_X) {
        if(is_printable) {
            echo("Detect thin walls: true");
            rotate(-90, VEC_Y) AFrameSide("outer", add_print_support = true);
        } else {
            AFrameSide("outer");
        }
    }
}
