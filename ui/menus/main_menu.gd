extends MarginContainer


func _on_play_button_up():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_exit_button_up():
	get_tree().quit()
