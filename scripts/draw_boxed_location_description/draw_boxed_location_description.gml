function draw_location_description_boxed(x1, y1, x2, y2) {
	draw_set_font(fnt_default);
	draw_set_color(c_white);
	draw_set_alpha(1);

	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	var gui_width = display_get_gui_width();
	var gui_height = display_get_gui_height();
	
	draw_text(gui_width / 2, y1, game_location_get().name);

	var description_width_pad = 0.2;
	draw_text_box(
		x1,
		y1 + gui_height * 0.05,
		x2,
		y2,
		game_location_get().description
	);
}
