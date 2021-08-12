class_name PlayerDectionArea
extends Area2D


var player_is_in_area := false
var player: KinematicBody2D


func _on_PlayerDetectionArea_body_entered(body):
	if body.is_in_group("player"):
		player_is_in_area = true
		player = body


func _on_PlayerDetectionArea_body_exited(body):
	if body.is_in_group("player"):
		player_is_in_area = false
		player = null
