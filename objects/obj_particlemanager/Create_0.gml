enemy_attacking = false
particles_bg = part_system_create(part_bg)
part_system_depth(particles_bg,100)
function clear(){
	part_particles_clear(particles_bg)
}
function rand_normal() {
    theta  = 2 * pi * random(1)
    R   = sqrt(-2 * log10(random(1)))
    rand_x   = R * cos(theta)
    return rand_x
}
function enemy_attack_create_particles(){
	for (var i = 0; i < 200; i++){
		instance_create_layer(rand_normal()*2000,-50,"Particles",obj_dmgparticle_enemy)
	}
}