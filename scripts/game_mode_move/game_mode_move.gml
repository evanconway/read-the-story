function game_mode_get_move() {
	return {
		update: function() {
			var location_name = game_location_get().name;
			var connections = ds_map_keys_to_array(global.location_connections[$ location_name]);
	
			var movement_options_grid = global.game.movement_options_grid;
	
			var move_v = 0;
			var move_h = 0;
			if (keyboard_check_pressed(vk_up)) move_v -= 1;
			if (keyboard_check_pressed(vk_down)) move_v += 1;
			if (keyboard_check_pressed(vk_left)) move_h -= 1;
			if (keyboard_check_pressed(vk_right)) move_h += 1;
			var new_y = game_movement_choice_get_v() + move_v;
			var new_x = game_movement_choice_get_h() + move_h;
			var new_y_valid = new_y >= 0 && new_y < array_length(movement_options_grid);
			var new_x_valid = new_x >= 0 && new_y_valid && new_x < array_length(movement_options_grid[new_y]);
	
			var movement_is_valid = method(
				{
					new_y_valid,
					new_x_valid,
					new_y,
					new_x,
					movement_options_grid,
				},
				function() {
					if (!new_y_valid) return false;
					if (!new_x_valid) return false;
					var new_move_dir = movement_options_grid[new_y][new_x];
					if (new_move_dir == -1) return false;
					return true;
				}
			);
	
			if (movement_is_valid()) {
				game_movement_choice_set([new_y, new_x])
			}
	
			var move_dir = movement_options_grid[game_movement_choice_get_v()][game_movement_choice_get_h()];
			if (keyboard_check_pressed(vk_enter) && array_contains(connections, move_dir)) {
				var new_location = global.locations[$ ds_map_find_value(global.location_connections[$ location_name], move_dir)];
				game_location_set(new_location);
				game_movement_choice_center();
				game_target_choice_set(0);
				obj_app.updateable = game_mode_get_targets();
			}
			if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_escape)) {
				obj_app.updateable = game_mode_get_targets();
			}
		},
		draw: function() {
			movement_draw_options(
				display_get_gui_width() / 2,
				display_get_gui_height() * 0.8,
				game_location_get(),
				global.game.movement_options_grid,
				[game_movement_choice_get_v(), game_movement_choice_get_h()]
			);
		}
	};
}
