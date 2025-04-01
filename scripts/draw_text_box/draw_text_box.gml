function draw_text_box(x, y, text, width, height) {
	var border = 2;
	var padding = 10;
	
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(x, y, x + width, y + height, false);
	draw_set_color(c_black);
	draw_rectangle(
		x + border,
		y + border,
		x + width - border,
		y + height - border,
		false
	);
	
	var text_width = width - (border * 2) - (padding * 2);
	var text_height = height - (border * 2) - (padding * 2);
	
	var text_x = x + border + padding;
	if (draw_get_halign() == fa_center) {
		text_x = x + (width / 2);
	}
	if (draw_get_halign() == fa_right) {
		text_x = x + width - border - padding;
	}
	
	var text_y = y + border + padding;
	if (draw_get_valign() == fa_middle) {
		text_y = y + (width / 2);
	}
	if (draw_get_valign() == fa_bottom) {
		text_y = y + width - border - padding;
	}
	
	draw_set_color(c_white);
	draw_set_font(fnt_default);
	draw_text_ext(text_x, text_y, text, string_height("A"), width);
}
