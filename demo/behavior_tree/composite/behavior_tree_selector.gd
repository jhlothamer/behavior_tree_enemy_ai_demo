#Selector for behavior trees
# stops evaluating children on first return of SUCCESS or RUNNING
class_name BTSelector, "behavior_tree_selector.svg"
extends BehaviorTreeBaseNode


export var random := false


var _last_result := -1
var _last_children := []


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	if has_bad_children():
		result.set_success()
		return

	for c in _get_children():
		var bc:BehaviorTreeNode = c
		bc.break_on_debug()
		bc.tick(delta, blackboard, result)
		if !result.is_failed():
			break
	
	_last_result = result.result


func _get_children() -> Array:
	var children = get_children()
	
	if random:
		#if was running last time - keep children order
		if _last_result == BehaviorTreeResult.Result.RUNNING:
			return _last_children
		children.shuffle()
		_last_children = children
	
	return children