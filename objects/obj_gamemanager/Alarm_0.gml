if (ds_list_size(discard) > 0){
	var card = ds_list_find_value(discard,ds_list_size(discard)-1)
	card.face_up = false
	card.target_x = draw_x_pos
	card.target_y = draw_y_pos - ds_list_size(deck)*3
	card.target_depth = -ds_list_size(deck)
	card.jolt_rot_only()
	ds_list_add(deck,card)
	ds_list_delete(discard,ds_list_size(discard)-1)
	alarm[0] = 5
	audio_play_sound(sfx_deal,0,false)
}
