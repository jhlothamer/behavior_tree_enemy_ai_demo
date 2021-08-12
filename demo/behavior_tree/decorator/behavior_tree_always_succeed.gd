#Decorator that always succeeds no matter the results of the child leaf
class_name BTAlwaysSucceed, "behavior_tree_always_succeed.svg"
extends BehaviorTreeBaseNode


func _validate_child_nodes() -> void:
	._validate_child_nodes()
	if _bad_child_node:
		_bad_child_node = get_child_count() == 1


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	if has_bad_children():
		result.set_success()
		return

	var bc:BehaviorTreeNode = get_child(0)
	bc.break_on_debug()
	bc.tick(delta, blackboard, result)
	
	if result.is_failed():
		result.set_success()
