# Sets data in blackboard from the given node's property/function.
# Note that functions must not require a parameter and should return a value.
class_name BTSetBlackBoardFromNodePropertyOrFunction
extends BehaviorTreeBaseNode

export var node: NodePath
export var node_property_or_function_name: String
export var blackboard_property_name: String

var _invalid := true
var _node: Node
var _is_function_call := false

func _ready():
	if node:
		_node = get_node(node)
	if !_node:
		printerr("BTSetBlackBoardFromProp: must set node")
		return
	if node_property_or_function_name == null or node_property_or_function_name == "":
		printerr("must set node property or function name")
		return

	if _node.has_method(node_property_or_function_name):
		_is_function_call = true

	if !blackboard_property_name:
		blackboard_property_name = node_property_or_function_name

	_invalid = false

func tick(delta:float, blackboard: BlackBoard, result:BehaviorTreeResult) -> void:
	if _invalid:
		result.set_failure()
		return
	
	if _is_function_call:
		blackboard.data[blackboard_property_name] = _node.call(node_property_or_function_name)
	else:
		blackboard.data[blackboard_property_name] = _node.get(node_property_or_function_name)
	
	result.set_success()
