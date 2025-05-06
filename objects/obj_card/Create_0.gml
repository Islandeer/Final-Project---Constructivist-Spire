card_id = 0
card_type = 0
face_up = false
in_player_hand = false
target_depth = 0
target_x = 0
target_y = 0
target_rot = 0
target_scale = 2
hovering = false
image_xscale = 2
image_yscale = 2
function jolt(){
	target_rot = 20
	target_scale = 2.2
	alarm[0] = 15
}
function jolt_rot_only(){
	target_rot = 20
	alarm[1] = 15
}