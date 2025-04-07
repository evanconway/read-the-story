draw_set_font(fnt_default);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(display_get_gui_width() / 2, 20, location.name);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();
var description_width_pad = 0.3;
draw_text_box(
	gui_width * description_width_pad,
	gui_height * 0.1,
	gui_width * (1 - description_width_pad),
	gui_height * 0.55,
	location.description
);

if (keyboard_check_pressed(ord("F"))) {
	window_set_fullscreen(!window_get_fullscreen());
} else if (keyboard_check_pressed(ord("M"))) {
	mode = MODE.MOVE;
	movement_choice = movement_center;
} else if (keyboard_check_pressed(vk_backspace) || keyboard_check_pressed(vk_escape)) {
	mode = MODE.TARGET;
} else if (mode == MODE.TARGET) {
	var targets = location_get_targets(location.name);
	var move_v = 0;
	if (keyboard_check_pressed(vk_up)) move_v -= 1;
	if (keyboard_check_pressed(vk_down)) move_v += 1;
	target_choice = clamp(target_choice + move_v, 0, array_length(targets) - 1);
	targets_menu_draw(gui_width / 2, gui_height * 0.7, targets, target_choice);
	if (keyboard_check_pressed(vk_enter)) {
		mode = MODE.EXAMINE;
	}
} else if (mode == MODE.EXAMINE) {
	var target = location_get_targets(location.name)[target_choice];
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_font(fnt_default);
	draw_set_color(c_white);
	draw_text(gui_width / 2, gui_height * 0.7, target.description);
} else if (mode == MODE.MOVE) {
	var connections = ds_map_keys_to_array(global.location_connections[$ location.name]);
	
	var move_v = 0;
	var move_h = 0;
	if (keyboard_check_pressed(vk_up)) move_v -= 1;
	if (keyboard_check_pressed(vk_down)) move_v += 1;
	if (keyboard_check_pressed(vk_left)) move_h -= 1;
	if (keyboard_check_pressed(vk_right)) move_h += 1;
	var new_y = movement_choice[0] + move_v;
	var new_x = movement_choice[1] + move_h;
	var new_y_valid = new_y >= 0 && new_y < array_length(movement_options_grid);
	var new_x_valid = new_x >= 0 && new_y_valid && new_x < array_length(movement_options_grid[new_y]);
	
	var movement_is_valid = method(
		{
			new_y_valid,
			new_x_valid,
			new_y, new_x,
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
		movement_choice = [new_y, new_x];
	}
	
	var move_dir = movement_options_grid[movement_choice[0]][movement_choice[1]];
	if (keyboard_check_pressed(vk_enter) && array_contains(connections, move_dir)) {
		location = global.locations[$ ds_map_find_value(global.location_connections[$ location.name], move_dir)];
		movement_choice = movement_center;
		mode = MODE.TARGET;
		target_choice = 0;
	} else {
		movement_draw_options(
			gui_width / 2,
			gui_height * 0.8,
			location,
			movement_options_grid,
			mode == MODE.MOVE ? movement_choice : []
		);
	}
}
