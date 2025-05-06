max_health = 50
y_accel = 0.025
y_speed = 0
image_xscale = 2
image_yscale = 2
display_health = max_health
enemy_health = max_health
base_atk = 0
current_atk = base_atk
backup_atk = base_atk
grow_atk = 5
wounded = 0
weak = 0
wiggle_left = true
dying = false
function intent(){
	backup_atk += grow_atk
	current_atk = backup_atk
}
function take_damage(damage){
	if (wounded == 0){
		enemy_health -= damage
	}
	else{
		enemy_health -= floor(damage*1.5)
	}
}
function die(){
	instance_create_layer(0,0,"Particles",obj_fracture)
}