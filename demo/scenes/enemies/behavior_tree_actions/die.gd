extends BTLeaf


func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var enemy: Enemy = blackboard.agent
	
	enemy.die()
	
	result.set_success()

