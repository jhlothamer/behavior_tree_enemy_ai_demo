extends BTLeaf


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy: Enemy = blackboard.agent
	
	if enemy.move_forward(delta):
		result.set_success()
	else:
		result.set_failure()
