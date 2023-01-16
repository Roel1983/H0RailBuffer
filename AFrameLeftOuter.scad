include <Constants.inc>
use <AFrameSide.scad>

AFrameLeftOuter(
    is_printable = true
);

module AFrameLeftOuter(
    is_printable = false
) {
    if(is_printable) {
        echo("Detect thin walls: true");
        rotate(-90, VEC_Y) AFrameSide("outer", add_print_support = true);
    } else {
        AFrameSide("outer");
    }
}
