function build_world() {
	var start = location_create("Start", "A blank room. There is nothing here. A blank room. There is nothing here. A blank room. There is nothing here. A blank room. There is nothing here. A blank room. There is nothing here.");
	var grove = location_create("Grove", "The trees are healthy and strong. The grass is green and lush. The trees are healthy and strong. The grass is green and lush. The trees are healthy and strong. The grass is green and lush.");
	var ice_cavern = location_create("Ice Cavern", "Your breathe turns to mist. The walls shimmer with a cold blue. Your breathe turns to mist. The walls shimmer with a cold blue. Your breathe turns to mist. The walls shimmer with a cold blue.");
	var fire_pit = location_create("Fire Pit", "Besides being unbearably hot, your feet burn from the heated sand. Besides being unbearably hot, your feet burn from the heated sand. Besides being unbearably hot, your feet burn from the heated sand.");
	var space_void = location_create("Space Void", "Galaxies of stars swirl around you. Galaxies of stars swirl around you. Galaxies of stars swirl around you. Galaxies of stars swirl around you. Galaxies of stars swirl around you.");

	location_add_connection(start, grove, LOCATION_CONNECTION_DIR.NORTH);
	location_add_connection(start, ice_cavern, LOCATION_CONNECTION_DIR.SOUTH);
	location_add_connection(start, fire_pit, LOCATION_CONNECTION_DIR.EAST);
	location_add_connection(start, space_void, LOCATION_CONNECTION_DIR.WEST);
	
	return global.locations[$ start];
}
