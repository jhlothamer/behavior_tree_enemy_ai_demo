extends KinematicBody2D

const UNIT_SIZE = 128


export var linear_speed := 300
export var max_jump_height_units: float = 2.25
export var min_jump_height_units = .8
export var jump_duration := .5

var _gravity: float
var _max_jump_velocity: float
var _min_jump_velocity: float
var _jumping := false

onready var _max_jump_height = max_jump_height_units * UNIT_SIZE
onready var _min_jump_height = min_jump_height_units * UNIT_SIZE
onready var _animated_sprite: AnimatedSprite = $AnimatedSprite
onready var _ground_detectors: Node2D = $GroundDetectors

var _velocity := Vector2.ZERO


func _ready():
	_gravity = 2 * _max_jump_height / pow(jump_duration, 2)
	_max_jump_velocity = -sqrt(2 * _gravity * _max_jump_height)
	_min_jump_velocity = -sqrt(2 * _gravity * _min_jump_height)


func _process(delta: float) -> void:
	var move_direction = -int(Input.is_action_pressed("move_left")) + int(Input.is_action_pressed("move_right"))
	_velocity.x = lerp(_velocity.x, linear_speed * move_direction, .2)
	if !is_zero_approx(_velocity.x):
		_animated_sprite.flip_h = _velocity.x < 0

	var is_grounded = _is_grounded()
	if Input.is_action_just_pressed("jump") and is_grounded:
		_velocity.y = _max_jump_velocity
		_animated_sprite.play("jump")
		_jumping = true
	elif !is_on_floor():
		_velocity.y += _gravity * delta
		if _velocity.y > 0:
			_jumping = false
	
	if _animated_sprite.animation == "fall":
		var enemy_falling_onto:Enemy = _get_enemy_player_on_top_of()
		if enemy_falling_onto:
			enemy_falling_onto.hurt_by_player()
	
	if !is_grounded:
		if _velocity.y > 0 and _animated_sprite.animation != "fall":
			_animated_sprite.play("fall")
	elif !_jumping:
		if abs(_velocity.x) < .1:
			if _animated_sprite.animation != "idle":
				_animated_sprite.play("idle")
		else:
			if _animated_sprite.animation != "run":
				_animated_sprite.play("run")
	
	_velocity = move_and_slide(_velocity, Vector2.UP)


func _is_grounded() -> bool:
	for r in _ground_detectors.get_children():
		if r.is_colliding():
			return true
	return false


func _get_enemy_player_on_top_of() -> Enemy:
	for r in _ground_detectors.get_children():
		if r.is_colliding():
			var collider = r.get_collider()
			if r.get_collider() is Enemy:
				return collider
	return null



