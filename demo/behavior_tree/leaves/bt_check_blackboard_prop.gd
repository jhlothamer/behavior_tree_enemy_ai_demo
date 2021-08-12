# checks blackboard for property
# if property doesn't exist, is null, "" (empty string) or False then the
# results are FAILURE.  Otherwise the results are SUCCESS.
class_name BTCheckBlackboardProperty
extends BehaviorTreeBaseNode

export var blackboard_property_name: String
	

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	var property = blackboard.data.get(blackboard_property_name)
	if !property:
		result.set_failure()
		return
	
	result.set_success()
