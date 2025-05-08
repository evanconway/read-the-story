game_location_set(build_world());

// updateable = game_mode_get_all();

chars = "abcdefghijklmnopqrstuvwxyz ";
var char_length = string_length(chars);
text = [];
for (var i = 0; i < 3000; i++) {
	var char_index = irandom_range(1, char_length);
	var new_char = string_char_at(chars, char_index);
	array_push(text, new_char);
}

draw = function() {
	draw_set_alpha(1);
	draw_set_font(fnt_default);
	draw_set_color(c_white);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	var draw_x = 0;
	var draw_y = 0;
	var text_height = string_height("A");
	var text_width = 0;
	for (var i = 0; i < array_length(text); i++) {
		draw_text(draw_x, draw_y, text[i]);
		text_width += string_width(text[i]);
		draw_x = text_width;
		if (text_width >= display_get_gui_width() * 0.9) {
			draw_y += text_height;
			text_width = 0;
			draw_x = 0;
		}
	}
};

updateable = {
	update: function() {},
	draw,
};
