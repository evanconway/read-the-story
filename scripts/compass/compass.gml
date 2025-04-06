function draw_compass(
	valid_dirs=[LOCATION_CONNECTION_DIR.NORTH],
	highlight_dir=undefined
) {
	// draw compass
	var compass_radius = 90;
	var compass_offset_x = 60;
	var compass_offset_y = 70;
	for (var i = 0; i < array_length(valid_dirs); i++) {
		var connection_dir = valid_dirs[i];
		var connection_name = location_direction_to_string(connection_dir);
	
		var angle = 0;
		if (connection_dir == LOCATION_CONNECTION_DIR.EAST) {
			angle = 0;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.NORTHEAST) {
			angle = 45;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.NORTH) {
			angle = 90;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.NORTHWEST) {
			angle = 135;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.WEST) {
			angle = 180;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.SOUTHWEST) {
			angle = 225;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.SOUTH) {
			angle = 270;
		}
		if (connection_dir == LOCATION_CONNECTION_DIR.SOUTHEAST) {
			angle = 315;
		}
	
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		if (connection_dir == highlight_dir) {
			draw_set_color(c_lime);
		}
		draw_text(
			compass_radius + compass_offset_x + lengthdir_x(compass_radius, angle),
			(display_get_gui_height() - (compass_radius + compass_offset_y)) + lengthdir_y(compass_radius, angle),
			connection_name
		);
	}
}
