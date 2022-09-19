draw_text(10, 10, "Bezier");

if (array_length(points) > 1) {
    var inc_value = 0.05 / array_length(points);
    
    for (var f = 0; f <= 1; f += inc_value) {
        var point = bezier.get_point(f);
        draw_circle(point.x, point.y, 3, false);
    }

    var progress_bezier = bezier.get_point(move_progress);
    draw_circle(progress_bezier.x, progress_bezier.y, 10, false);
    
    for (var i = 0, size_i = array_length(points); i < size_i; i++) {
        draw_circle_color(points[i].x, points[i].y, 4, c_red, c_red, false);
        if (i < size_i - 1) {
        	draw_line(points[i].x, points[i].y, points[i + 1].x, points[i + 1].y);
        }
    }
        
}

bezier.debug_draw_sub_points();