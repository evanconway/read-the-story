function draw_text_box_bordered(x1, y1, x2, y2, text) {
	var border = 2;
	var padding = 10;
	
	draw_set_color(c_white);
	draw_set_alpha(1);
	draw_rectangle(x1, y1, x2, y2, false);
	draw_set_color(c_black);
	draw_rectangle(
		x1 + border,
		y1 + border,
		x2 - border,
		y2 - border,
		false
	);
	
	var width = x2 - x1;
	var height = y2 - y1;
	
	var text_width = width - (border * 2) - (padding * 2);
	var text_height = height - (border * 2) - (padding * 2);
	
	var text_x = x1 + border + padding;
	if (draw_get_halign() == fa_center) {
		text_x = x1 + (width / 2);
	}
	if (draw_get_halign() == fa_right) {
		text_x = x1 + width - border - padding;
	}
	
	var text_y = y1 + border + padding;
	if (draw_get_valign() == fa_middle) {
		text_y = y1 + (height / 2);
	}
	if (draw_get_valign() == fa_bottom) {
		text_y = y1 + height - border - padding;
	}
	
	draw_text_box(text_x, text_y, text, text_width);
}
