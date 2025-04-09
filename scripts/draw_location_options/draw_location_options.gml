function draw_location_options_box(x1, y1, choice) {
	var left_start = 0.2;
	var description_end = 0.5;
	var options_start = 0.55;
			
	var gui_width = display_get_gui_width();
	var gui_height = display_get_gui_height();
		
	draw_set_font(fnt_default);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	var connections = game_location_get_connections_arr();
	var targets = game_location_get_targets();
	var total_arr_length = array_length(targets) + array_length(connections);
	var draw_x = x1;
	var draw_y = y1;
	var line_height = string_height("A");
	for (var i = 0; i < total_arr_length; i++) {
		draw_set_color(i == choice ? c_white : c_dkgray);
		if (i < array_length(targets)) {
			draw_text(draw_x, draw_y, targets[i].name)
		} else {
			var con_i = i - array_length(targets);
			var connection = connections[con_i];
			draw_text(draw_x, draw_y, connection.dir_string);
		}
		draw_y += line_height;
	}
}
