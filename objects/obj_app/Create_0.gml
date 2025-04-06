location = build_world();

enum MODE {
	TARGET,
	MOVE,
}

mode = MODE.TARGET;

// -1 is no option, -2 is the center
movement_options_grid = [
	[-1, LOCATION_CONNECTION_DIR.UP],
	[LOCATION_CONNECTION_DIR.NORTHWEST, LOCATION_CONNECTION_DIR.NORTH, LOCATION_CONNECTION_DIR.NORTHEAST],
	[LOCATION_CONNECTION_DIR.WEST, -2, LOCATION_CONNECTION_DIR.EAST],
	[LOCATION_CONNECTION_DIR.SOUTHWEST, LOCATION_CONNECTION_DIR.SOUTH, LOCATION_CONNECTION_DIR.SOUTHEAST],
	[-1, LOCATION_CONNECTION_DIR.DOWN],
];
movement_center = [2, 1]
movement_choice = movement_center;
