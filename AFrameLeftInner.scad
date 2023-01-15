include <Constants.inc>
use <AFrameSide.scad>

AFrameLeftInner(
    is_printable = true
);

module AFrameLeftInner(
    is_printable = false
) {
    if(is_printable) {
        rotate(-90, VEC_Y) AFrameSide("inner");
    } else {
        mirror(VEC_X) AFrameSide("inner");
    }
}