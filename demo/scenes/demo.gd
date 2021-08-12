extends Control


func _on_GroundEnemyDemoBtn_pressed():
	get_tree().change_scene("res://scenes/demos/ground_enemy_ai_demo.tscn")


func _on_ExitBtn_pressed():
	get_tree().quit()


func _on_AirEnemyDemoBtn_pressed():
	get_tree().change_scene("res://scenes/demos/air_enemy_ai_demo.tscn")
