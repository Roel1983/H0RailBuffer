include <Config.inc>
include <Constants.inc>
use <AFrameLeftInner.scad>
use <AFrameLeftOuter.scad>
use <AFrameRightInner.scad>
use <AFrameRightOuter.scad>
use <Block.scad>

Buffer();

module Buffer() {
    color("DimGray") AFrameLeft();
    color("DimGray") AFrameRight();
    color("Red") Block();

    module AFrameLeft() {
        translate([rail_distance / 2, 0]) {
            AFrameLeftInner();
            AFrameLeftOuter();
        }
    }

    module AFrameRight() {
        translate([-rail_distance / 2, 0]) {
            AFrameRightInner();
            AFrameRightOuter();
        }
    }
}