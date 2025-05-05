function draw_text_box(x, y, text, width) {
	draw_set_valign(fa_top);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fnt_default);
	draw_text_ext(x, y, text, string_height("A"), width);
}
