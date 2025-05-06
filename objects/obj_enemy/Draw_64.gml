draw_set_font(font_small)
draw_set_halign(fa_left)
draw_sprite(spr_enemyatk,0,x+256,y+144)
draw_text(x+278,y+208,string(current_atk))
if(wounded > 0){
	draw_sprite(spr_wounded,0,x+320,y+144)
	draw_text(x+342,y+208,wounded)
}
if (weak > 0){
	draw_sprite(spr_weak,0,x+384,y+144)
	draw_text(x+406,y+208,weak)
}
draw_text(x+256,y+64,string(enemy_health)+"/"+string(max_health))
draw_rectangle_color(x+256,y+128,x+512,y+144,c_gray,c_gray,c_gray,c_gray,false)
draw_rectangle_color(x+256,y+128,x+256+256*(display_health/max_health),y+144,c_red,c_red,c_red,c_red,false)