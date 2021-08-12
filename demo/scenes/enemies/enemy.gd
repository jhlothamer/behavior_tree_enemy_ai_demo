class_name Enemy
extends KinematicBody2D

signal died(enemy)


func idle() -> void:
	pass


func move_towards_player(_delta: float) -> void:
	pass


func turn_towards_player() -> void:
	pass


func move_forward(_delta: float) -> void:
	pass


func hurt_by_player() -> void:
	pass


func is_dying() -> bool:
	return false


func die() -> void:
	pass
