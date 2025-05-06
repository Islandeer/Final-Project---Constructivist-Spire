if (abs(display_health-enemy_health)>1){
	display_health = lerp(display_health,enemy_health,0.15)
}
if (y_speed >= 1){
	y_accel = -0.025
}
if (y_speed <= -1){
	y_accel = 0.025
}
if (weak > 0){
	current_atk = floor(backup_atk*0.5)
}
y_speed += y_accel
y += y_speed
if (enemy_health <= 0){
	if (!dying){
		die()
		dying = true
	}
	enemy_health = 0
	image_alpha -= 0.01
	if (wiggle_left){
		wiggle_left = false
		x -= 2
	}
	else{
		wiggle_left = true
		x += 2
	}
}