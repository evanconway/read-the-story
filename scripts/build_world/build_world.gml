function build_world() {
	var start = new Location("Start", "A blank room. There is nothing here.");
	var grove = new Location("Grove", "The trees are healthy and strong. The grass is green and lush.");
	var ice_cavern = new Location("Ice Cavern", "Your breathe turns to mist. The walls shimmer with a cold blue.");
	var fire_pit = new Location("Fire Pit", "Besides being unbearably hot, your feet burn from the heated sand.");
	var space_void = new Location("Space Void", "Galaxies of stars swirl around you.");

	location_add_connection(start, grove);
	location_add_connection(start, ice_cavern);
	location_add_connection(start, fire_pit);
	location_add_connection(start, space_void);
	
	return start;
}