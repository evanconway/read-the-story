function InteractableText(text, width=800) constructor {
	draw_set_font(fnt_default);
	var chars_length = string_length(text);
	// feather ignore GM1043
	char_array = array_map(array_create(chars_length), method({ text }, function(_, index) {
		var char = string_char_at(text, index + 1);
		return {
			character: char,
			width: string_width(char),
			height: string_height(char),
			x: 0,
			y: 0,
		};
	}));
	
	var curr_word = {
		text: "", // just for debugging
		width: 0,
		index_start: 0,
		index_end: 0, // inclusive
	};
	var line_width = 0;
	var line_height = 0;
	var char_x = 0;
	var char_y = 0;
	
	for (var i = 0; i < chars_length; i++) {
		// continue adding to existing word
		if (char_array[i].character != " ") {
			curr_word.text += char_array[i].character;
			curr_word.width += char_array[i].width;
			curr_word.index_end = i;
		}
		// add word to line or start new line
		// always add word on last character
		if (char_array[i].character == " " || i == chars_length - 1) {
			// determine if new line should be started
			if (line_width + curr_word.width >= width) {
				line_width = 0;
				char_x = 0;
				char_y += line_height;
				line_height = 0;
			}
			
			// add to current line
			for (var c = curr_word.index_start; c <= i; c++) {
				var char_adding = char_array[c];
				char_adding.x = char_x;
				char_adding.y = char_y;
				char_x += char_adding.width;
				line_width += char_adding.width;
				line_height = max(line_height, char_adding.height);
			}
			// reset current word
			curr_word.text = "";
			curr_word.width = 0;
			curr_word.index_start = i + 1;
			curr_word.index_end = i + 1;
		}
	}
	show_debug_message("finished");
}

function interactable_text_draw(i_text) {
	with (i_text) {
		draw_set_font(fnt_default);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		for (var i = 0; i < array_length(char_array); i++) {
			var char = char_array[i];
			draw_text(char.x, char.y, char.character);
		}
	}
}