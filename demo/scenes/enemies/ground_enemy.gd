class_name GroundEnemy
extends Enemy


export var linear_speed := 100
export var chase_player_linear_speed := 200
export var max_jump_height_units: float = 2.25
export var min_jump_height_units = .8
export var jump_duration := .5
export var gravity: float = 40.0


onready var _animated_sprite: AnimatedSprite = $AnimatedSprite
onready var _collision_shape: CollisionShape2D = $CollisionShape2D
onready var _player_close_area: PlayerDectionArea = $PlayerCloseDetectionArea
onready var _player_near_area: PlayerDectionArea = $PlayerNearDetectionArea


var _velocity := Vector2.ZERO
var _is_dying := false



func turn_around() -> void:
	_animated_sprite.flip_h = !_animated_sprite.flip_h


func move_towards_player(delta: float) -> void:
	_move(chase_player_linear_speed)


func move_forward(delta: float) -> bool:
	return _move(linear_speed)


func idle() -> void:
		if _animated_sprite.animation != "idle" or !_animated_sprite.playing:
			_animated_sprite.speed_scale = 1.0
			_animated_sprite.play("idle")


func turn_towards_player():
	var player = _get_player()
	_animated_sprite.flip_h = player.global_position.x < global_position.x


func is_touching_player():
	for i in get_slide_count():
		var c := get_slide_collision(i)
		if c.collider is Node and c.collider.is_in_group("player"):
			return true
	return false


func attack():
	if _animated_sprite.animation != "attack":
		_animated_sprite.speed_scale = 1.0
		_animated_sprite.play("attack")


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


func _move(speed: float) -> bool:
	_velocity.x = speed
	
	if _animated_sprite.flip_h:
		_velocity.x *= -1.0
	
	if !is_on_floor():
		_velocity.y += gravity
	
	if _animated_sprite.animation != "walk":
		_animated_sprite.play("walk")
	
	var speed_scale = abs(_velocity.x) / linear_speed
	if _animated_sprite.speed_scale != speed_scale:
		_animated_sprite.speed_scale = speed_scale
	
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
	return !is_on_wall()


func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation != "dead":
		return
	emit_signal("died", self)
	queue_free()


