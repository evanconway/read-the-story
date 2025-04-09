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
			draw_location_description_boxed();
			var targets = location_get_targets(game_location_get().name);
			var target_choice = game_target_choice_get();
			targets_menu_draw(display_get_gui_width() / 2, display_get_gui_height() * 0.7, targets, target_choice);
		}
	};
}
