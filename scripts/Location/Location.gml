function Location (name, description = "no description") constructor {
	location_name = name;
	location_description = description;
	connections = {};
}

function location_add_connection(location, other_location) {
	struct_set(location.connections, other_location.location_name, other_location);
	struct_set(other_location.connections, location.location_name, location);
};
