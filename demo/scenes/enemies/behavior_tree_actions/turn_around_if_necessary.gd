extends BTLeaf


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy: Enemy = blackboard.agent
	
	if enemy.is_colliding_with_wall():
		enemy.turn_around()

	result.set_success()
