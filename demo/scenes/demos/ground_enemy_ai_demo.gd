extends Node2D

onready var _enemy_parent:Node2D = $EnemyParent

var _enemy_class = preload("res://scenes/enemies/ground_enemy.tscn")
var _smoke_animation_class = preload("res://scenes/etc/smoke_animation.tscn")

onready var _enemy_spawn_position = $EnemyParent/GroundEnemy.global_position


func _on_GroundEnemy_died(dying_enemy: Node):
	# wait till enemy really gone
	yield(dying_enemy,"tree_exited")
	yield(get_tree().create_timer(4),"timeout")
	# use smoke animation to signal spawning of enemy
	var smoke_animation = _smoke_animation_class.instance()
	_enemy_parent.add_child(smoke_animation)
	smoke_animation.global_position = _enemy_spawn_position
	yield(smoke_animation,"animation_finished")
	smoke_animation.queue_free()
	# spawn enemy
	var enemy = _enemy_class.instance()
	enemy.connect("died", self, "_on_GroundEnemy_died")
	_enemy_parent.add_child(enemy)
	enemy.global_position = _enemy_spawn_position

