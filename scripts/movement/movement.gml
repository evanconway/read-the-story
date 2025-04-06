function movement_draw_options(
	x,
	y,
	location,
	grid=[
		[-1, LOCATION_CONNECTION_DIR.UP],
		[LOCATION_CONNECTION_DIR.NORTHWEST, LOCATION_CONNECTION_DIR.NORTH, LOCATION_CONNECTION_DIR.NORTHEAST],
		[LOCATION_CONNECTION_DIR.WEST, -2, LOCATION_CONNECTION_DIR.EAST],
		[LOCATION_CONNECTION_DIR.SOUTHWEST, LOCATION_CONNECTION_DIR.SOUTH, LOCATION_CONNECTION_DIR.SOUTHEAST],
		[-1, LOCATION_CONNECTION_DIR.DOWN],
	],
	choice=[2, 1]
) {
	// connections is a ds_map where each key is a LOCATION_CONNECTION_DIR and each value is the string name of a location
	var connections = global.location_connections[$ location.name];
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_default);
	var text_width = string_width("an option");
	var text_height = string_height("A");
	var cell_width = text_width * 1.05;
	var cell_height = text_height * 2.1;
	
	var movement_options_width = 0;
	var movement_options_height = 0;
	for (var i = 0; i < array_length(grid); i++) {
		movement_options_height += cell_height;
		var acc_option_widths = 0;
		for (var k = 0; k < array_length(grid[i]); k++) {
			acc_option_widths += cell_width
		}
		movement_options_width = max(movement_options_width, acc_option_widths);
	}
	
	var draw_y = y - (movement_options_height / 2) + cell_height / 2;
	for (var i = 0; i < array_length(grid); i++) {
		var draw_x = x - (movement_options_width / 2) + cell_width / 2;
		for (var k = 0; k < array_length(grid[i]); k++) {
			var location_name = ds_map_find_value(connections, grid[i][k]);
			var drawn_name = is_undefined(location_name) ? "-" : location_name;
			if (grid[i][k] == -1) {
				drawn_name = "";
			}
			draw_set_color(c_dkgray);
			if (array_length(choice) == 2 && choice[0] == i && choice[1] == k) {
				draw_set_color(c_white);
			}
			draw_text_ext(draw_x, draw_y, drawn_name, text_height, text_width);
			draw_x += cell_width;
		}
		draw_y += cell_height;
	}
}
