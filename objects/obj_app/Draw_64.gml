draw_set_font(fnt_default);
draw_set_color(c_white);
draw_set_alpha(1);

draw_text(0, 0, location.location_description);

var draw_exits_y = display_get_gui_height() * 0.75;
var exits = struct_get_names(location.connections);
for (var i = 0; i < array_length(exits); i++) {
	draw_text(0, draw_exits_y, exits[i]);
	draw_exits_y += string_height(exits[i]);
}
