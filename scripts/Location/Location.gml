enum LOCATION_CONNECTION_DIR {
	NORTH,
	SOUTH,
	EAST,
	WEST,
	NORTHWEST,
	NORTHEAST,
	SOUTHWEST,
	SOUTHEAST,
	UP,
	DOWN
}

function __get_reverse_location_connection_dir(location_dir) {
	if (location_dir == LOCATION_CONNECTION_DIR.NORTH) return LOCATION_CONNECTION_DIR.SOUTH;
	if (location_dir == LOCATION_CONNECTION_DIR.SOUTH) return LOCATION_CONNECTION_DIR.NORTH;
	if (location_dir == LOCATION_CONNECTION_DIR.EAST) return LOCATION_CONNECTION_DIR.WEST;
	if (location_dir == LOCATION_CONNECTION_DIR.WEST) return LOCATION_CONNECTION_DIR.EAST;
	
	if (location_dir == LOCATION_CONNECTION_DIR.NORTHWEST) return LOCATION_CONNECTION_DIR.SOUTHEAST;
	if (location_dir == LOCATION_CONNECTION_DIR.SOUTHEAST) return LOCATION_CONNECTION_DIR.NORTHWEST;
	if (location_dir == LOCATION_CONNECTION_DIR.NORTHEAST) return LOCATION_CONNECTION_DIR.SOUTHWEST;
	if (location_dir == LOCATION_CONNECTION_DIR.SOUTHWEST) return LOCATION_CONNECTION_DIR.NORTHEAST;
	
	if (location_dir == LOCATION_CONNECTION_DIR.UP) return LOCATION_CONNECTION_DIR.DOWN;
	if (location_dir == LOCATION_CONNECTION_DIR.DOWN) return LOCATION_CONNECTION_DIR.UP;
	return -1;
}

function location_direction_to_string(location_dir) {
	if (location_dir == LOCATION_CONNECTION_DIR.NORTH) return "North";
	if (location_dir == LOCATION_CONNECTION_DIR.SOUTH) return "South";
	if (location_dir == LOCATION_CONNECTION_DIR.EAST) return "East";
	if (location_dir == LOCATION_CONNECTION_DIR.WEST) return "West";
	
	if (location_dir == LOCATION_CONNECTION_DIR.NORTHWEST) return "North West";
	if (location_dir == LOCATION_CONNECTION_DIR.SOUTHEAST) return "South East";
	if (location_dir == LOCATION_CONNECTION_DIR.NORTHEAST) return "North East";
	if (location_dir == LOCATION_CONNECTION_DIR.SOUTHWEST) return "South West";
	
	if (location_dir == LOCATION_CONNECTION_DIR.UP) return "Up";
	if (location_dir == LOCATION_CONNECTION_DIR.DOWN) return "Down";
	return "no direciton";
}

global.locations = {};
global.location_connections = {};

/**
 * @param {string} name the name of locations must be unique
 * @param {string} description the default description of this location
 */
function location_create (name, description = "no description") {
	var location = {
		name,
		description,
	};
	struct_set(global.locations, name, location);
	return name;
}

/**
 */
function location_add_connection(name_a, name_b, connection_direction, add_reverse = true) {
	if (!struct_exists(global.location_connections, name_a)) {
		global.location_connections[$ name_a] = ds_map_create();
	}
	
	var existing_connections = global.location_connections[$ name_a];
	
	if (ds_map_exists(existing_connections, connection_direction)) {
		show_error($"Tried to create more than one connection from {name_a} to direction: {connection_direction}", true);
	}
	ds_map_set(existing_connections, connection_direction, name_b);
	if (add_reverse) {
		location_add_connection(name_b, name_a, __get_reverse_location_connection_dir(connection_direction), false);
	}
};
