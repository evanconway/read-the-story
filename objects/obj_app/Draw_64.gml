draw_set_font(fnt_default);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(0, 0, location.description);

var draw_exits_y = display_get_gui_height() * 0.75;
var connections = ds_map_keys_to_array(global.location_connections[$ location.name]);

// draw compass
var compass_radius = 90;
var compass_offset_x = 60;
var compass_offset_y = 70;
for (var i = 0; i < array_length(connections); i++) {
	var connection_dir = connections[i];
	var connection_name = location_direction_to_string(connection_dir);
	
	var angle = 0;
	if (connection_dir == LOCATION_CONNECTION_DIR.EAST) {
		angle = 0;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.NORTHEAST) {
		angle = 45;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.NORTH) {
		angle = 90;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.NORTHWEST) {
		angle = 135;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.WEST) {
		angle = 180;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.SOUTHWEST) {
		angle = 225;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.SOUTH) {
		angle = 270;
	}
	if (connection_dir == LOCATION_CONNECTION_DIR.SOUTHEAST) {
		angle = 315;
	}
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(
		compass_radius + compass_offset_x + lengthdir_x(compass_radius, angle),
		(display_get_gui_height() - (compass_radius + compass_offset_y)) + lengthdir_y(compass_radius, angle),
		connection_name
	);
}
