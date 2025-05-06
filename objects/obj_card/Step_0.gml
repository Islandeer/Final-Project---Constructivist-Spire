if (abs(x-target_x)>1){
	x = lerp(x,target_x,0.15)
}
else{
	x = target_x
}
if (abs(y-target_y)>1){
	y = lerp(y,target_y,0.15)
}
else{
	y = target_y
}

if (abs(image_angle-target_rot)>1){
	image_angle = lerp(image_angle,target_rot,0.15)
}
else{
	image_angle = target_rot
}
if (abs(image_xscale-target_scale)>0.01){
	image_xscale = lerp(image_xscale,target_scale,0.15)
	image_yscale = lerp(image_yscale,target_scale,0.15)
}
else{
	image_xscale = target_scale
	image_yscale = target_scale
}
depth = target_depth
if (face_up){
	image_index = card_type
}
else{
	image_index = 4
}
switch(global.state){
	case STATES.DEAL:
		break;
	case STATES.PICK:
		if (ds_list_size(obj_gamemanager.player_selected) < 1){
			if (in_player_hand){
				if (position_meeting(mouse_x,mouse_y,id) && mouse_check_button_pressed(mb_left)){
					if(card_type == 0 || card_type == 1 || card_type == 3){
						if (obj_gamemanager.player_energy >= 1){
							obj_gamemanager.player_energy -= 1
							hovering = false
							audio_play_sound(sfx_deal,0,false)
							show_debug_message("selected "+string(card_id))
							target_y -= 128
							ds_list_add(obj_gamemanager.player_selected,id)
							ds_list_delete(obj_gamemanager.player_hand,ds_list_find_index(obj_gamemanager.player_hand,id))
						}
					}
					else{
						if (obj_gamemanager.player_energy >= 2){
							obj_gamemanager.player_energy -= 2
							hovering = false
							audio_play_sound(sfx_deal,0,false)
							show_debug_message("selected "+string(card_id))
							target_y -= 128
							ds_list_add(obj_gamemanager.player_selected,id)
							ds_list_delete(obj_gamemanager.player_hand,ds_list_find_index(obj_gamemanager.player_hand,id))
						}
					}
				}
				if (position_meeting(mouse_x,mouse_y,id)&&!hovering){
					hovering = true
					target_depth -= 100
					target_y -= 16
				}
				if (!position_meeting(mouse_x,mouse_y,id)&&hovering){
					hovering = false
					target_depth += 100
					target_y += 16
				}
			}
		}
		else{
			global.state = STATES.COMPARE
		}
		break; 
	case STATES.COMPARE:
		break;
	case STATES.RESOLVE:
		break;
	case STATES.RESHUFFLE:
		break;
}