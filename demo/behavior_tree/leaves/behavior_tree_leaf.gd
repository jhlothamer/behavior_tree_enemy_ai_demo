#Leaf of behavior tree.  Extend this type to create new condition or action nodes
class_name BTLeaf, "behavior_tree_leaf.svg"
extends BehaviorTreeBaseNode

func _validate_child_nodes() -> void:
	if get_child_count() > 0:
		printerr("BTLeaf: should not have any child nodes.  Leaf node path: %s" % get_path())
		_bad_child_node = true


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	if has_bad_children():
		result.set_failure()
		return

	result.set_success()
