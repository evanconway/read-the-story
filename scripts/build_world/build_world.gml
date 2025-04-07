function build_world() {
	var start = location_create("Start", "A blank room. There is nothing here. A blank room. There is nothing here. A blank room. There is nothing here. A blank room. There is nothing here. A blank room. There is nothing here.");
	target_set_location(target_create("table", "It has square top and 4 wooden legs. Simple but functional.").target_id, start);
	target_set_location(target_create("candle", "The candle looks about half-way burned.").target_id, start);
	
	var grove = location_create("Grove", "The trees are healthy and strong. The grass is green and lush. The trees are healthy and strong. The grass is green and lush. The trees are healthy and strong. The grass is green and lush.");
	target_set_location(target_create("wide tree", "The shortest tree here, but it's expanse is surprising. Some branches are horizontal and laying on the ground.").target_id, grove);
	target_set_location(target_create("tall tree", "It stands up perfectly straight. The top is not visible.").target_id, grove);
	target_set_location(target_create("golden bush", "A small bush with light golden leaves. There appears to be a slight metallic sheen to it.").target_id, grove);
	
	var ice_cavern = location_create("Ice Cavern", "Your breathe turns to mist. The walls shimmer with a cold blue. Your breathe turns to mist. The walls shimmer with a cold blue. Your breathe turns to mist. The walls shimmer with a cold blue.");
	target_set_location(target_create("floor", "It's slightly slipper, but not too much to stand and walk on.").target_id, ice_cavern);
	target_set_location(target_create("peculiar spike", "In a corner one ice spike rises higher than expected. There's a purple tint in the middle.").target_id, ice_cavern);
	
	var fire_pit = location_create("Fire Pit", "Besides being unbearably hot, your feet burn from the heated sand. Besides being unbearably hot, your feet burn from the heated sand. Besides being unbearably hot, your feet burn from the heated sand.");
	target_set_location(target_create("sand", "A dark yellow color. Hot as fire.").target_id, fire_pit);
	
	var space_void = location_create("Space Void", "Galaxies of stars swirl around you. Galaxies of stars swirl around you. Galaxies of stars swirl around you. Galaxies of stars swirl around you. Galaxies of stars swirl around you.");
	target_set_location(target_create("infinity", "As beautiful as it is incomprehensible.").target_id, space_void);

	location_add_connection(start, grove, LOCATION_CONNECTION_DIR.NORTH);
	location_add_connection(start, ice_cavern, LOCATION_CONNECTION_DIR.SOUTH);
	location_add_connection(start, fire_pit, LOCATION_CONNECTION_DIR.EAST);
	location_add_connection(start, space_void, LOCATION_CONNECTION_DIR.WEST);
	
	return global.locations[$ start];
}
