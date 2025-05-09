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

ishmael = "Call me Ishmael. Some years ago—never mind how long precisely—having little or no money in my purse, and nothing particular to interest me on shore, I thought I would sail about a little and see the watery part of the world. It is a way I have of driving off the spleen and regulating the circulation. Whenever I find myself growing grim about the mouth; whenever it is a damp, drizzly November in my soul; whenever I find myself involuntarily pausing before coffin warehouses, and bringing up the rear of every funeral I meet; and especially whenever my hypos get such an upper hand of me, that it requires a strong moral principle to prevent me from deliberately stepping into the street, and methodically knocking people’s hats off—then, I account it high time to get to sea as soon as I can. This is my substitute for pistol and ball. With a philosophical flourish Cato throws himself upon his sword; I quietly take to the ship. There is nothing surprising in this. If they but knew it, almost all men in their degree, some time or other, cherish very nearly the same feelings towards the ocean with me.";

test_text = new InteractableText(ishmael);
