action_timer = 0
action_cooldown = 20
enemy = instance_find(obj_enemy,0)
enemy_atk = 0
enemy_def = 0
intent_selected = false
player_atk = 0
player_def = 0
player_score = 0
player_pick = obj_card
shuffling = false
player_energy = 3
waiting_to_discard = true
win_alarm_set = false
enemy_attacked = false
enum STATES{
	DEAL,
	PICK,
	COMPARE,
	RESOLVE,
	RESHUFFLE
}
global.state = STATES.DEAL
hand_x_offset = 128
num_cards = 10
dealing = true
deck = ds_list_create()
player_hand = ds_list_create()
player_selected = ds_list_create()
discard = ds_list_create()
draw_x_pos = 0.1*room_width
draw_y_pos = 0.5*room_height
discard_x_pos = 0.9*room_width
discard_y_pos = 0.5*room_height
for (i = 0; i < num_cards; i++){
	var new_card = instance_create_layer(draw_x_pos,draw_y_pos,"Instances",obj_card)
	if (i<4){
		new_card.card_type = 0
	}
	else if (i<8){
		new_card.card_type = 1
	}
	else if (i == 8){
		new_card.card_type = 2
	}
	else if (i == 9){
		new_card.card_type = 3
	}
	new_card.card_id = i
	new_card.face_up = false;
	new_card.in_player_hand = false
	ds_list_add(deck,new_card)
}

randomize()
ds_list_shuffle(deck)
for (i = 0; i < ds_list_size(deck); i++){
	card = ds_list_find_value(deck,i)
	card.y -= i*3
	card.target_depth = -i
	card.target_x = card.x
	card.target_y = card.y
}