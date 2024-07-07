extends MarginContainer


func _on_try_again_button_up():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_back_to_menu_button_up():
	get_tree().change_scene_to_file("res://ui/menus/main_menu.tscn")
