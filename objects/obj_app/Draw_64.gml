draw_set_font(fnt_default);
draw_set_color(c_white);
draw_set_alpha(1);

draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(display_get_gui_width() / 2, 20, location.name);

var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();
draw_text_box(
	gui_width * 0.2,
	gui_height * 0.1,
	gui_width * 0.8,
	gui_height * 0.55,
	location.description
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

draw_compass(connections, travel_dir)
