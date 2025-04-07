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

if (mode == MODE.TARGET) {
	var targets = location_get_targets(location.name);
	targets_menu_draw(gui_width / 2, gui_height * 0.7, targets, target_choice);
} else if (mode == MODE.EXAMINE) {
	var target = location_get_targets(location.name)[target_choice];
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_font(fnt_default);
	draw_set_color(c_white);
	draw_text(gui_width / 2, gui_height * 0.7, target.description);
} else if (mode == MODE.MOVE) {
	movement_draw_options(
		gui_width / 2,
		gui_height * 0.8,
		location,
		movement_options_grid,
		mode == MODE.MOVE ? movement_choice : []
	);
}
