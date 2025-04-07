global.game = {
	location: "",
	movement_options_grid: [
		[-1, LOCATION_CONNECTION_DIR.UP],
		[LOCATION_CONNECTION_DIR.NORTHWEST, LOCATION_CONNECTION_DIR.NORTH, LOCATION_CONNECTION_DIR.NORTHEAST],
		[LOCATION_CONNECTION_DIR.WEST, -2, LOCATION_CONNECTION_DIR.EAST],
		[LOCATION_CONNECTION_DIR.SOUTHWEST, LOCATION_CONNECTION_DIR.SOUTH, LOCATION_CONNECTION_DIR.SOUTHEAST],
		[-1, LOCATION_CONNECTION_DIR.DOWN],
	],
	movement_center: [2, 1],
	movement_choice: [2, 1],
	target_choice: 0,
};

function game_location_set(location) {
	global.game.location = location;
}

function game_location_get() {
	return global.game.location;
}

function game_movement_choice_set(new_choice) {
	global.game.movement_choice = new_choice;
}

function game_movement_choice_get_v() {
	return global.game.movement_choice[0];
}

function game_movement_choice_get_h() {
	return global.game.movement_choice[1];
}

function game_movement_choice_center() {
	game_movement_choice_set(global.game.movement_center);
}

function game_target_choice_set(new_choice) {
	global.game.target_choice = new_choice;
}

function game_target_choice_get() {
	return global.game.target_choice;
}

function game_mode_get_targets() {
	return {
		update: function() {
			var targets = location_get_targets(game_location_get().name);
			var move_v = 0;
			if (keyboard_check_pressed(vk_up)) move_v -= 1;
			if (keyboard_check_pressed(vk_down)) move_v += 1;
			var target_choice = game_target_choice_get();
			var new_choice = clamp(target_choice + move_v, 0, array_length(targets) - 1);
			game_target_choice_set(new_choice);
			if (keyboard_check_pressed(vk_enter)) {
				obj_app.updateable = game_mode_get_examine();
			}
			if (keyboard_check_pressed(ord("M"))) {
				obj_app.updateable = game_mode_get_move();
			}
		},
		draw: function() {
			var targets = location_get_targets(game_location_get().name);
			var target_choice = game_target_choice_get();
			targets_menu_draw(display_get_gui_width() / 2, display_get_gui_height() * 0.7, targets, target_choice);
		}
	};
}

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

function game_mode_get_examine() {
	return {
		update: function() {
			if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_escape)) {
				obj_app.updateable = game_mode_get_targets();
			}
		},
		draw: function() {
			var location_name = game_location_get().name;
			var target_choice = game_target_choice_get();
			var target = location_get_targets(location_name)[target_choice];
			draw_set_valign(fa_middle);
			draw_set_halign(fa_center);
			draw_set_font(fnt_default);
			draw_set_color(c_white);
			draw_text(display_get_gui_width() / 2, display_get_gui_height() * 0.7, target.description);
		}
	};
}
