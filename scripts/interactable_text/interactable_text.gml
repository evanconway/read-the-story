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
				
				// later, this is where we'll have to add words for detection
			}
			// reset current word
			curr_word.text = "";
			curr_word.width = 0;
			curr_word.index_start = i + 1;
			curr_word.index_end = i + 1;
		}
	}
	show_debug_message("finished");
	
	// construct initial drawables
	drawables = {
		previous: undefined,
		next: undefined,
		index_start: 0,
		index_end: 0, // inclusive
		text: char_array[0].character,
		style: {
			alpha: 1,
			color: c_white,
		},
	}
	var curr_drawable = drawables;
	var curr_y = char_array[0].y; // using y position like line_index to determine if chars can be part of same drawable
	
	for (var i = 1; i < array_length(char_array); i++) {
		if (char_array[i].y == curr_y) {
			// char on same line
			curr_drawable.index_end = i;
			curr_drawable.text += char_array[i].character;
		} else {
			var new_drawable = {
				previous: curr_drawable,
				next: undefined,
				index_start: i,
				index_end: i, // inclusive
				text: char_array[i].character,
				style: {
					alpha: 1,
					color: c_white,
				},
			}
			curr_y = char_array[i].y;
			curr_drawable.next = new_drawable;
			curr_drawable = new_drawable;
		}
	}
	
}

function interactable_text_draw(i_text) {
	with (i_text) {
		draw_set_font(fnt_default);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		var drawable = drawables;
		while (drawable != undefined) {
			var anchor_char = char_array[drawable.index_start];
			draw_text(anchor_char.x, anchor_char.y, drawable.text);
			drawable = drawable.next
		}
	}
}