resolution = {
	width: 1280,
	height: 720
};
var scale = 2;

window_set_size(resolution.width * scale, resolution.height * scale);
surface_resize(application_surface, resolution.width, resolution.height);
display_set_gui_size(resolution.width, resolution.height);

var center_window = time_source_create(
	time_source_game,
	1,
	time_source_units_frames,
	window_center
);
time_source_start(center_window);
