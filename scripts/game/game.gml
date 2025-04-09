global.game = {
	location: "",
	movement_options_grid: [
		[-1, LOCATION_CONNECTION_DIR.UP],
		[LOCATION_CONNECTION_DIR.NORTHWEST, LOCATION_CONNECTION_DIR.NORTH, LOCATION_CONNECTION_DIR.NORTHEAST],
		[LOCATION_CONNECTION_DIR.WEST, -2, LOCATION_CONNECTION_DIR.EAST],
		[LOCATION_CONNECTION_DIR.SOUTHWEST, LOCATION_CONNECTION_DIR.SOUTH, LOCATION_CONNECTION_DIR.SOUTHEAST],
		[-1, LOCATION_CONNECTION_DIR.DOWN],
	],
	movement_center: [2, 1],
	movement_choice: [2, 1],
	target_choice: 0,
};

function game_location_set(location) {
	global.game.location = location;
}

function game_location_get() {
	return global.game.location;
}

function game_location_get_connections_arr() {
	var location_name = game_location_get().name;
	var connections = global.location_connections[$ location_name];
	var connection_keys = ds_map_keys_to_array(connections);
	array_sort(connection_keys, function(a, b) {
		var val_a = location_get_dir_sort_value(a);
		var val_b = location_get_dir_sort_value(b);
		return val_a - val_b;
	});
	var result = array_map(connection_keys, method({ connections }, function(key) {
		var location_name = ds_map_find_value(connections, key);
		return {
			dir: key,
			dir_string: $"{location_name} ({location_direction_to_string(key)})",
			location_name
		};
	}));
	return result;
}

/**
 * Get the map of current location connections where key is direction and value is location.
 *
 * @return {Id.DsMap}
 */
function game_location_get_connections() {
	var location_name = game_location_get().name;
	return global.location_connections[$ location_name];
}

function game_location_get_targets() {
	return location_get_targets(game_location_get().name);
}

function game_movement_choice_set(new_choice) {
	global.game.movement_choice = new_choice;
}

function game_movement_choice_get_v() {
	return global.game.movement_choice[0];
}

function game_movement_choice_get_h() {
	return global.game.movement_choice[1];
}

function game_movement_choice_center() {
	game_movement_choice_set(global.game.movement_center);
}

function game_target_choice_set(new_choice) {
	global.game.target_choice = new_choice;
}

function game_target_choice_get() {
	return global.game.target_choice;
}
