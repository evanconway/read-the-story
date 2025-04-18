function game_mode_get_all() {	
	return {
		choice: 0,
		update: function() {
			var connections = game_location_get_connections_arr();
			var targets = game_location_get_targets();
			var total_arr_length = array_length(targets) + array_length(connections);
			
			var move_v = 0;
			if (keyboard_check_pressed(vk_up)) {
				move_v -= 1;
			}
			if (keyboard_check_pressed(vk_down)) {
				move_v += 1;
			}
			choice = clamp(choice + move_v, 0, total_arr_length - 1);
			
			if (keyboard_check_pressed(vk_enter)) {
				if (choice < array_length(targets)) {
					
				} else {
					var con_i = choice - array_length(targets);
					var location_name = connections[con_i].location_name;
					var new_location = global.locations[$ location_name];
					game_location_set(new_location);
					choice = 0;
				}
			}
			
		},
		draw: function() {								
			var gui_width = display_get_gui_width();
			var gui_height = display_get_gui_height();
			var width_pad = 0.2;
			draw_location_description_boxed(
				gui_width * width_pad,
				gui_height * 0.02,
				gui_width * (1 - width_pad),
				gui_height * 0.5
			);
			draw_location_options_box(
				gui_width * width_pad,
				gui_height * 0.55,
				choice
			);
			
			draw_set_color(c_white);
			draw_set_alpha(1);
			draw_set_font(fnt_default);
			
			var targets = game_location_get_targets();
			var line_height = string_height("A");
			if (choice < array_length(targets)) {
				var target = targets[choice];
				draw_text_ext(
					gui_width * 0.4,
					gui_height * 0.55,
					target.description,
					line_height,
					gui_width * 0.4
				);
			}
		},
	};
}
