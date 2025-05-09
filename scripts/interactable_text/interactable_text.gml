function InteractableText(text, width=800) constructor {
	draw_set_font(fnt_default);
	var chars_length = string_length(text);
	// feather ignore GM1043
	char_array = array_map(array_create(chars_length), method({ text }, function(_, index) {
		var char = string_char_at(text, index - 1);
		return {
			character: char,
			width: string_width(char),
			height: string_height(char),
			x: 0,
			y: 0
		};
	}));
	var curr_word = {
		text: "", // this may not be necessary
		width: 0,
		index_start: 0,
		index_end: 0, // inclusive
	};
	var line_length = 0;
	
	// note that we'll think of spaces as their own "word"
	
	for (var i = 0; i < chars_length; i++) {
		var char = char_array[i].character;
		// continue adding to existing word
		if (char != " ") {
			curr_word.width += char.width;
			curr_word.index_end = i;
		}
		// add word to line or start new line
		if (char == " ") {
			if (line_length + curr_word.width < width) {
				// add to current line
				
				// assign
				
			} else {
				// start new line
			}
		}
		
	}
}
