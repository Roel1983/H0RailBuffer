include <Constants.inc>
use <AFrameSide.scad>

AFrameRightInner(
    is_printable = true
);

module AFrameRightInner(
    is_printable = false
) {
    if(is_printable) {
        echo("Detect thin walls: true");
        rotate(-90, VEC_Y) AFrameSide("inner", add_print_support = true);
    } else {
        AFrameSide("inner");
    }
}