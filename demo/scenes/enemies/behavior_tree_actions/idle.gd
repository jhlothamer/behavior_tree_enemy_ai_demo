extends BTLeaf

export var idle_time := 4.0
export var walk_time := 4.0

var _idle_timer := 0.0
var _time_since_last_idle := 0.0

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	_time_since_last_idle += delta
	
	if _time_since_last_idle < walk_time:
		result.set_failure()
		return
	
	
	_idle_timer += delta
	if _idle_timer >= idle_time:
		_time_since_last_idle = 0.0
		_idle_timer = 0.0
		result.set_failure()
		return
	
	var enemy: Enemy = blackboard.agent
	enemy.idle()

	result.set_running(self)
