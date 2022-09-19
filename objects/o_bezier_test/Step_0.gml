if (mouse_check_button_pressed(mb_left)) {
    array_push(points, new Point(mouse_x, mouse_y));
    recalc_bezier();
}

move_progress = (move_progress + (1 / 320)) % 1;