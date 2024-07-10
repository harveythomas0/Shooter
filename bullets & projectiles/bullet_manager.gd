extends Node2D


func handle_bullets(bullets):
	for bullet in bullets:
		add_child(bullet)
