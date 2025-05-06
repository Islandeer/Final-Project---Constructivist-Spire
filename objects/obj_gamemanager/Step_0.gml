if (action_timer == 0){
	action_timer = action_cooldown
	show_debug_message(global.state)
	switch(global.state){
		case STATES.DEAL:
			player_energy = 3
			if(!intent_selected){
				obj_enemy.intent()
				if (obj_enemy.weak > 0){
					enemy_atk = floor(obj_enemy.backup_atk*0.5)
				}
				else{
					enemy_atk = obj_enemy.backup_atk
				}
				intent_selected = true
			}
			if (ds_list_size(player_hand) < 5){
				var dealt_card_player = ds_list_find_value(deck,ds_list_size(deck)-1)
				ds_list_delete(deck,ds_list_size(deck)-1)
				ds_list_add(player_hand,dealt_card_player)
				audio_play_sound(sfx_deal,0,false)
				dealt_card_player.target_x = room_width/5.5 + ds_list_size(player_hand) * hand_x_offset
				dealt_card_player.target_y = room_height * 0.7
				dealt_card_player.in_player_hand = true
				dealt_card_player.face_up = true
				dealt_card_player.hovering = false
				show_debug_message("given card " + string(dealt_card_player.card_id) + " to player" + "target y = " + string(dealt_card_player.target_y))
			}
			else{
				global.state = STATES.PICK
			}
			break;
		case STATES.PICK:
			waiting_to_discard = true
			break
		case STATES.COMPARE:
			player_pick = ds_list_find_value(player_selected,0)
			if (!waiting_to_discard){
				player_pick.jolt()
				if (player_pick.card_type == 0){
					obj_enemy.take_damage(6)
					for (var i = 0; i < 10; i++){
						instance_create_layer(enemy.x+128,enemy.y+128,"Particles",obj_dmgparticle)
					}
					audio_play_sound(sfx_dmg,0,false)
				}
				if (player_pick.card_type == 1){
					player_def += 5
				}
				if (player_pick.card_type == 2){
					obj_enemy.take_damage(8)
					audio_play_sound(sfx_dmg,0,false)
					for (var i = 0; i < 10; i++){
						instance_create_layer(enemy.x+128,enemy.y+128,"Particles",obj_dmgparticle)
					}
					obj_enemy.wounded += 2
				}
				if (player_pick.card_type == 3){
					obj_enemy.weak += 2
				}
				var card = ds_list_find_value(player_selected,0);
				ds_list_clear(player_selected);
				card.face_up = true
				card.in_player_hand = false
				card.target_x = discard_x_pos
				card.target_y = discard_y_pos - ds_list_size(discard)*3
				card.target_depth = -ds_list_size(discard)
				audio_play_sound(sfx_deal,0,false)
				ds_list_add(discard,card)
				show_debug_message("discarded "+string(card.card_id))
				if (player_energy == 0){
					global.state = STATES.RESOLVE
				}
				else{
					global.state = STATES.PICK
				}
			}
			else{
				waiting_to_discard = false
			}
			break;


		case STATES.RESOLVE:
			if (obj_enemy.weak > 0){
					enemy_atk = floor(obj_enemy.backup_atk*0.5)
			}
			if (enemy_attacked){
				if (obj_enemy.enemy_health > 0 && enemy_atk > player_def){
					global.playerhealth-=(enemy_atk-player_def)
				}
				if (obj_enemy.wounded > 0){
					obj_enemy.wounded -= 1
				}
				if (obj_enemy.weak > 0){
					obj_enemy.weak -= 1
				}
				player_def = 0
				for (i = 0; i < ds_list_size(player_hand); i++){
					audio_play_sound(sfx_deal,0,false)
					var card = ds_list_find_value(player_hand,i);
					card.face_up = true
					card.in_player_hand = false
					card.target_x = discard_x_pos
					card.target_y = discard_y_pos - ds_list_size(discard)*3
					card.target_depth = -ds_list_size(discard)
					ds_list_add(discard,card)
					show_debug_message("discarded "+string(card.card_id))
				}
				ds_list_clear(player_hand)
				ds_list_clear(player_selected)
				if (ds_list_size(deck) == 0){
					global.state = STATES.RESHUFFLE
				}
				else{
					global.state = STATES.DEAL
				}
				intent_selected = false
				enemy_attacked = false
			}
			else{
				enemy_attacked = true
				audio_play_sound(sfx_dmg,0,false)
				obj_particlemanager.enemy_attack_create_particles()
			}
			break;
		case STATES.RESHUFFLE:
			if (!shuffling){
				shuffling = true
				show_debug_message(global.state)
				alarm[0] = 5
				alarm[1] = 5 * num_cards + action_cooldown
			}
			break;
	}
}
action_timer--
if(obj_enemy.enemy_health<=0){
	if (!win_alarm_set){
		win_alarm_set = true
		alarm[2] = 120
	}
	
}
if(global.playerhealth<=0){
	obj_particlemanager.clear()
	room_goto(room_loss)
}
if (abs(global.player_display_health-global.playerhealth)>1){
	global.player_display_health = lerp(global.player_display_health,global.playerhealth,0.15)
}