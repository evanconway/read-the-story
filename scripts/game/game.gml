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
