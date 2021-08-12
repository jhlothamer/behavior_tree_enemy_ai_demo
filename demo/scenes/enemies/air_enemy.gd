class_name AirEnemy
extends Enemy

export var linear_speed := 200

onready var _animated_sprite: AnimatedSprite = $AnimatedSprite
onready var _collision_shape: CollisionShape2D = $CollisionShape2D
onready var _player_close_area: PlayerDectionArea = $PlayerCloseDetectionArea
onready var _player_near_area: PlayerDectionArea = $PlayerNearDetectionArea

var _is_dying := false


func idle():
	if _animated_sprite.animation != "idle":
		_animated_sprite.play("idle")


func attack():
	if _animated_sprite.animation != "attack":
		_animated_sprite.play("attack")


func move_towards_player(delta: float) -> void:
	var player = _get_player()
	_move_towards(player.global_position, delta)


func turn_towards_player() -> void:
	var player = _get_player()
	_face_towards(player.global_position)


func is_dying() -> bool:
	return _is_dying


func hurt_by_player() -> void:
	_is_dying = true


func die() -> void:
	if _animated_sprite.animation == "dead":
		return
	_animated_sprite.speed_scale = 1.0
	_animated_sprite.play("dead")
	_collision_shape.disabled = true

func _get_player() -> Node2D:
	var player: Node2D = _player_near_area.player
	if !player:
		player = _player_close_area.player

	return player


func _face_towards(position: Vector2) -> void:
	_animated_sprite.flip_h = position.x < global_position.x


func _move_towards(position: Vector2, delta: float) -> bool:
	if _animated_sprite.animation != "fly":
		_animated_sprite.play("fly")
	
	var linear_velocity = (position - global_position).normalized() * linear_speed
	
	move_and_slide(linear_velocity)
	
	return false


func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation != "dead":
		return
	emit_signal("died", self)
	queue_free()



