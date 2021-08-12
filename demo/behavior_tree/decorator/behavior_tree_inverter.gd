#Decorator that inverts the results of the child leaf
# this means SUCCESS => FAILURE, FAILURE => SUCCESS and RUNNING => RUNNING
class_name BTInverter, "behavior_tree_inverter.svg"
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
	
	if result.is_succeeded():
		result.set_failure()
	elif result.is_failed():
		result.set_success()


