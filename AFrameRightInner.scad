include <Constants.inc>
use <AFrameSide.scad>

AFrameRightInner(
    is_printable = true
);

module AFrameRightInner(
    is_printable = false
) {
    if(is_printable) {
        rotate(-90, VEC_Y) AFrameSide("inner");
    } else {
        AFrameSide("inner");
    }
}