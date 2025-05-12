game_location_set(build_world());

// updateable = game_mode_get_all();

ishmael = "Call me Ishmael. Some years ago-never mind how long precisely-having little or no money in my purse, and nothing particular to interest me on shore, I thought I would sail about a little and see the watery part of the world. It is a way I have of driving off the spleen and regulating the circulation. Whenever I find myself growing grim about the mouth; whenever it is a damp, drizzly November in my soul; whenever I find myself involuntarily pausing before coffin warehouses, and bringing up the rear of every funeral I meet; and especially whenever my hypos get such an upper hand of me, that it requires a strong moral principle to prevent me from deliberately stepping into the street, and methodically knocking people's hats off-then, I account it high time to get to sea as soon as I can. This is my substitute for pistol and ball. With a philosophical flourish Cato throws himself upon his sword; I quietly take to the ship. There is nothing surprising in this. If they but knew it, almost all men in their degree, some time or other, cherish very nearly the same feelings towards the ocean with me.";

test_text = new InteractableText(ishmael, [
	{
		text: "Ishmael",
		callback: function() {
			show_debug_message("You clicked my name.");
		}
	}
]);

updateable = {
	update: method({ test_text }, function() {
		if (mouse_check_button_pressed(mb_left)) {
			interactable_text_highlight_invoke_callback(test_text);
		}
	}),
	draw: method({ test_text }, function() {
		draw_text(0, 0, $"({mouse_x}, {mouse_y})");
		var text_pos = { x: 100, y: 100};
		interactable_text_highlight_word_at_xy(test_text, text_pos.x, text_pos.y, mouse_x, mouse_y);
		interactable_text_draw(test_text, text_pos.x, text_pos.y);
	}),
};
