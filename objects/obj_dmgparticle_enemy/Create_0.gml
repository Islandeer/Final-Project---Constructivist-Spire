size = random_range(2,4)
random_direction = random(360)
y_vel = (room_width/2-abs(x-room_width/2)) * 0.05 * random_range(0.25,1)
lifespan = 60
alarm[0] = lifespan
image_xscale = size
image_yscale = size
