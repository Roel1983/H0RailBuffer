include <Constants.inc>
use <AFrameSide.scad>

AFrameLeftOuter(
    is_printable = true
);

module AFrameLeftOuter(
    is_printable = false
) {
    if(is_printable) {
        rotate(-90, VEC_Y) AFrameSide("outer");
    } else {
        AFrameSide("outer");
    }
}
