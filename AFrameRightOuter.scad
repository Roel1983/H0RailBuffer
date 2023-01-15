include <Constants.inc>
use <AFrameSide.scad>

AFrameRightOuter(
    is_printable = true
);

module AFrameRightOuter(
    is_printable = false
) {
    if(is_printable) {
        rotate(-90, VEC_Y) AFrameSide("outer");
    } else {
        mirror(VEC_X) AFrameSide("outer");
    }
}
