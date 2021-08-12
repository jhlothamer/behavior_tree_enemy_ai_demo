extends BTLeaf


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy: Enemy = blackboard.agent
	
	enemy.move_towards_player(delta)

	result.set_success()
