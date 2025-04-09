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
