show_debug_overlay(true);

points = [];    /// @is {Point[]}
bezier = new Bezier();

function recalc_bezier() {
	if (array_length(points) > 1) {
    	bezier.set_points(points);
        bezier.refresh();
	}
}

move_progress = 0;