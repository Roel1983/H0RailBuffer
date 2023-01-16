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
            rotate(-90, VEC_Y) AFrameSide("inner");
        } else {
            AFrameSide("inner");
        }
    }
}