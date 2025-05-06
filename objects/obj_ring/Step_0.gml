image_angle -= 0.25
if (size_speed >= 0.01){
	size_accel = -size_accel
}
if (size_speed <= -0.01){
	size_accel = -size_accel
}
size_speed += size_accel
size += size_speed
image_xscale = size
image_yscale = size