extends BTLeaf


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy: Enemy = blackboard.agent
	
	enemy.attack()

	result.set_success()
