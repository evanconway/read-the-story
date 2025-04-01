draw_set_font(fnt_default);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(display_get_gui_width() / 2, 20, location.name);

var description_width = display_get_gui_width() * 0.65;
var description_height = display_get_gui_height() * 0.4;
draw_text_box(
	display_get_gui_width() / 2 - description_width / 2,
	display_get_gui_height() * 0.1,
	location.description,
	description_width,
	description_height
);

var travel_x = 0;
var travel_y = 0;
if (keyboard_check(vk_up)) travel_y -= 1;
if (keyboard_check(vk_down)) travel_y += 1;
if (keyboard_check(vk_left)) travel_x -= 1;
if (keyboard_check(vk_right)) travel_x += 1;

var travel_dir = -1;
if (travel_x = 1 && travel_y = 0) travel_dir = LOCATION_CONNECTION_DIR.EAST;
if (travel_x = 1 && travel_y = -1) travel_dir = LOCATION_CONNECTION_DIR.NORTHEAST;
if (travel_x = 0 && travel_y = -1) travel_dir = LOCATION_CONNECTION_DIR.NORTH;
if (travel_x = -1 && travel_y = -1) travel_dir = LOCATION_CONNECTION_DIR.NORTHWEST;
if (travel_x = -1 && travel_y = 0) travel_dir = LOCATION_CONNECTION_DIR.WEST;
if (travel_x = -1 && travel_y = 1) travel_dir = LOCATION_CONNECTION_DIR.SOUTHWEST;
if (travel_x = 0 && travel_y = 1) travel_dir = LOCATION_CONNECTION_DIR.SOUTH;
if (travel_x = 1 && travel_y = 1) travel_dir = LOCATION_CONNECTION_DIR.SOUTHEAST;

var connections = ds_map_keys_to_array(global.location_connections[$ location.name]);

if (array_contains(connections, travel_dir) && keyboard_check_pressed(vk_space)) {
	location = global.locations[$ ds_map_find_value(global.location_connections[$ location.name], travel_dir)];
}

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
	draw_set_color(c_white);
	if (connection_dir == travel_dir) {
		draw_set_color(c_lime);
	}
	draw_text(
		compass_radius + compass_offset_x + lengthdir_x(compass_radius, angle),
		(display_get_gui_height() - (compass_radius + compass_offset_y)) + lengthdir_y(compass_radius, angle),
		connection_name
	);
}
