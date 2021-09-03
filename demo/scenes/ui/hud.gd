extends CanvasLayer


func _on_BackBtn_pressed():
	get_tree().change_scene("res://scenes/demo.tscn")


func _input(event):
	if event.is_echo():
		return
	if event.is_action_pressed("pause"):
		var tree := get_tree()
		tree.paused = !tree.paused
