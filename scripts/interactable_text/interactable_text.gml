function InteractableText(text, matches=[], width=800) constructor {
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
			drawable: undefined,
			match: undefined,
		};
	}));
	
	// rig matches with char_array
	// match data shape: { text: string, callback: function }
	for (var i = 0; i < array_length(matches); i++) {
		var match = matches[i];
		var pos_i = string_pos_ext(match.text, text, 1) - 1;
		var pos_i_end = pos_i + string_length(match.text) - 1;
		var match_data = {
			text: match.text,
			callback: match.callback,
			words: [], // filled later by line break logic
			highlight_all: struct_exists(match, "highlight_all") ? match.highlight_all : false,
		};
		while (pos_i >= 0) {
			for (var c = pos_i; c <= pos_i_end; c++) {
				char_array[c].match = match_data;
			}
			pos_i = string_pos_ext(match.text, text, pos_i + 2) - 1;
			pos_i_end = pos_i + string_length(match.text) - 1;
		}
	}
	
	// setup word highlight logic
	var curr_word_row = { y: 0, height: 0, words: [] };
	words = [curr_word_row];
	highlighted_row = -1;
	highlighted_column = -1;
	static get_highlighted_word = function() {
		if (highlighted_row < 0 || highlighted_row >= array_length(words)) return undefined;
		var words_row = words[highlighted_row].words;
		if (highlighted_column < 0 || highlighted_column >= array_length(words_row)) return undefined;
		return words_row[highlighted_column];
	};
	
	// calculate line breaks and character positions
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
	
	static get_collection_word = function(word) {
		var punc = [".", ",", "?", "!", ";", ":", "\""];
		var result = { word: "", x: 0, y: 0, width: 0 };
		var index_start = word.index_start;
		var index_end = word.index_end;
		
		// adjust word start/end to exclude punctuation
		while (array_contains(punc, char_array[index_start].character) && index_start <= index_end) index_start += 1;
		while (array_contains(punc, char_array[index_end].character) && index_start <= index_end) index_end -= 1;
		if (index_start > index_end) return undefined;
		var text = "";
		var width = 0;
		for (var i = index_start; i <= index_end; i++) {
			text += char_array[i].character;
			width += char_array[i].width;
		}
		return {
			word: text,
			index_start,
			x: char_array[index_start].x,
			y: char_array[index_start].y,
			width,
		};
	};
	
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
				curr_word_row = { y: char_y, height: 0, words: [] };
				array_push(words, curr_word_row);
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
			
			// add word to collection
			var collection_word = get_collection_word(curr_word);
			array_push(curr_word_row.words, collection_word);
			// add word to match reference at character
			var match_data_at_char = char_array[collection_word.index_start].match;
			if (match_data_at_char != undefined) {
				array_push(match_data_at_char.words, collection_word);
			}
			
			// set row height for word collection
			curr_word_row.height = max(curr_word_row.height, line_height);
			
			// reset current word
			curr_word.text = "";
			curr_word.width = 0;
			curr_word.index_start = i + 1;
			curr_word.index_end = i + 1;
		}
	}
	
	// build drawables
	drawables = {
		prev: undefined,
		next: undefined,
		index_start: 0,
		index_end: 0, // inclusive
		text: char_array[0].character,
		style: {
			alpha: 1,
			color: c_white,
		},
	};
	char_array[0].drawable = drawables;
	var curr_drawable = drawables;
	var curr_y = char_array[0].y; // using y position like line_index to determine if chars can be part of same drawable
	
	for (var i = 1; i < array_length(char_array); i++) {
		if (char_array[i].y == curr_y) {
			curr_drawable.index_end = i;
			curr_drawable.text += char_array[i].character;
		} else {
			var new_drawable = {
				prev: curr_drawable,
				next: undefined,
				index_start: i,
				index_end: i, // inclusive
				text: char_array[i].character,
				style: {
					alpha: 1,
					color: c_white,
				},
			}
			curr_drawable.next = new_drawable;
			curr_drawable = new_drawable;
			curr_y = char_array[i].y;
			
		}
		char_array[i].drawable = curr_drawable;
	}
	
	show_debug_message("interactable text complete \n");
}

function interactable_text_highlight_clear(i_text) {
	i_text.highlighted_row = -1;
	i_text.highlighted_column = -1;
}

function interactable_text_highlight_word_at_xy(i_text, text_x, text_y, x, y, with_space_buffer = false) {
	interactable_text_highlight_clear(i_text);
	with (i_text) {
		var row_index = array_find_index(words, method({ text_y, y}, function(row, row_index) {
			var row_y = text_y + row.y;
			var row_y_end = row_y + row.height;
			return y >= row_y && y < row_y_end;
		}));
		if (row_index < 0) return;
		var row = words[row_index];
		
		// add a small buffer to account for spaces between words
		var word_index = -1;
		if (!with_space_buffer) {
			word_index = array_find_index(row.words, method({ text_x, x }, function(word) {
				var word_x = text_x + word.x;
				var word_x_end = word_x + word.width;
				return x > word_x && x < word_x_end;
			}));
			if (word_index < 0) return;
		} else {
			var space_buffer = 0;
			while (word_index < 0) {
				word_index = array_find_index(row.words, method({ text_x, x, space_buffer }, function(word) {
					var word_x = text_x + word.x;
					var word_x_end = word_x + word.width;
					return x > (word_x - space_buffer) && x < (word_x_end + space_buffer);
				}));
				space_buffer += 1;
				
				// infinite cut-off, just in case
				if (space_buffer > 500) {
					show_debug_message("interactable_text_highlight_word_at_xy exceeded space_buffer cutoff");
					return;
				}
			}
		}
		highlighted_row = row_index;
		highlighted_column = word_index;
	}
};

function interactable_text_highlight_word_row_prev(i_text) {
	with (i_text) {
		if (highlighted_row == 0) return;
		var word = get_highlighted_word();
		if (word == undefined) {
			highlighted_row = 0;
			highlighted_column = 0;
			return;
		}
		var word_mid_x = word.x + word.width/2;
		var row_pre_change = highlighted_row;
		highlighted_row = clamp(highlighted_row - 1, 0, array_length(words) - 1);
		var row_data = words[highlighted_row];
		interactable_text_highlight_word_at_xy(self, 0, 0, word_mid_x, row_data.y, true);
		
		// handle over-hang
		if (get_highlighted_word() == undefined) {
			highlighted_row = row_pre_change - 1;
			highlighted_column = array_length(words[highlighted_row].words) - 1;
		}
	}
}

function interactable_text_highlight_word_row_next(i_text) {
	with (i_text) {
		if (highlighted_row >= array_length(words)) return;
		var word = get_highlighted_word();
		if (word == undefined) {
			highlighted_row = 0;
			highlighted_column = 0;
			return;
		}
		var word_mid_x = word.x + word.width/2;
		var row_pre_change = highlighted_row;
		highlighted_row = clamp(highlighted_row + 1, 0, array_length(words) - 1);
		var row_data = words[highlighted_row];
		interactable_text_highlight_word_at_xy(self, 0, 0, word_mid_x, row_data.y, true);
		
		// handle over-hang
		if (get_highlighted_word() == undefined) {
			highlighted_row = row_pre_change + 1;
			highlighted_column = array_length(words[highlighted_row].words) - 1;
		}
	}
}

function interactable_text_highlight_word_col_prev(i_text) {
	with (i_text) {
		highlighted_row = clamp(highlighted_row, 0, array_length(words) - 1);
		highlighted_column = clamp(highlighted_column - 1, 0, array_length(words[highlighted_row].words) - 1);
	}
}

function interactable_text_highlight_word_col_next(i_text) {
	with (i_text) {
		highlighted_row = clamp(highlighted_row, 0, array_length(words) - 1);
		highlighted_column = clamp(highlighted_column + 1, 0, array_length(words[highlighted_row].words) - 1);
	}
}

function interactable_text_highlight_invoke_callback(i_text) {
	with (i_text) {
		var highlighted_word = get_highlighted_word();
		if (highlighted_word == undefined) return;
		var match = char_array[highlighted_word.index_start].match;
		if (match == undefined) return;
		match.callback();
	}
}

function interactable_text_draw(i_text, x, y) {
	with (i_text) {
		draw_set_font(fnt_default);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		var drawable = drawables;
		while (drawable != undefined) {
			var anchor_char = char_array[drawable.index_start];
			draw_set_alpha(drawable.style.alpha);
			draw_set_color(drawable.style.color);
			draw_text(x + anchor_char.x, y + anchor_char.y, drawable.text);
			drawable = drawable.next;
		}
		var highlighted_word = get_highlighted_word();
		if (highlighted_word != undefined) {
			draw_set_alpha(1);
			draw_set_color(c_lime);
			var match = char_array[highlighted_word.index_start].match;
			if (match != undefined && match.highlight_all) {
				for (var w = 0; w < array_length(match.words); w++) {
					var word = match.words[w];
					var anchor_char = char_array[word.index_start];
					draw_text(x + anchor_char.x, y + anchor_char.y, word.word);
				}
			} else {
				draw_text(x + highlighted_word.x, y + highlighted_word.y, highlighted_word.word);
			}
		}
	}
}
