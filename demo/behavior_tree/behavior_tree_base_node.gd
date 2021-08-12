# Behavior tree base class that has some validation checks
class_name BehaviorTreeBaseNode
extends BehaviorTreeNode

var _bad_child_node := false


func _ready() -> void:
	set_physics_process(false)
	set_process(false)
	_validate_child_nodes()


func _validate_child_nodes() -> void:
	for c in get_children():
		if !c is BehaviorTreeNode:
			printerr("Only behavior tree nodes allowed in tree.  Bad node at %s" % c.get_path())
			_bad_child_node = true
			break

func has_bad_children():
	return _bad_child_node

