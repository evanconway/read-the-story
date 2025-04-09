
function draw_location_description_boxed() {
	draw_set_font(fnt_default);
	draw_set_color(c_white);
	draw_set_alpha(1);

	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_text(display_get_gui_width() / 2, 20, game_location_get().name);

	var gui_width = display_get_gui_width();
	var gui_height = display_get_gui_height();
	var description_width_pad = 0.3;
	draw_text_box(
		gui_width * description_width_pad,
		gui_height * 0.1,
		gui_width * (1 - description_width_pad),
		gui_height * 0.55,
		game_location_get().description
	);
}
