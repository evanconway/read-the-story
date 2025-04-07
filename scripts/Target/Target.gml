global.targets = ds_map_create();
global.target_locations = ds_map_create();

/*
A target is anything the player can interact with. This could be something as simple
as a decorative element in a location with a simple description. Or it could be
something more complex that interacts with other game elements
*/

function target_create(name, description="") {
	static target_id_src = 0;
	var target = {
		target_id: target_id_src,
		name,
		description,
	};
	target_id_src += 1;
	
	target.get_description = method(target, function() {
		return target_description;
	});
	
	ds_map_add(global.targets, target.target_id, target);
	return target;
}

function target_set_location(target_id, location_name) {
	ds_map_set(global.target_locations, target_id, location_name);
}

function target_get_location(target_id) {
	return ds_map_find_value(global.target_locations, target_id);
}

function targets_menu_draw(x, y, targets, choice) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_default);
	var option_height = string_height("A");
	var height = array_length(targets) * option_height;
	var draw_y = y - height/2;
	for (var i = 0; i < array_length(targets); i++) {
		draw_set_color(i == choice ? c_white : c_dkgray);
		draw_text(x, draw_y, targets[i].name);
		draw_y += option_height;
	}
}
