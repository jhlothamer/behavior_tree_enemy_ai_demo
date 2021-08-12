#Behavior Tree.  Acts as root.  Only allows a single child node.
class_name BehaviorTree, "behavior_tree.svg"
extends Node


enum SyncType {
	Idle,
	Physics
}


export var agent:NodePath
export var blackboard:NodePath
export var visibility_notifier:NodePath
export (SyncType) var sync_type := SyncType.Physics


var _agent:Node
var _blackboard:BlackBoard
var _current_running_node:Node


func _ready():
	set_process(false)
	set_physics_process(false)
	
	var errors := false
	
	if blackboard:
		_blackboard = get_node_or_null(blackboard)
	if !_blackboard:
		printerr("BehaviorTree: must have valid blackboard")
		errors = true
	
	if agent:
		_agent = get_node(agent)
	if !_agent:
		printerr("BehaviorTree: must have valid agent")
		errors = true
	
	_blackboard.agent = _agent
	
	if !errors and visibility_notifier:
		var vn:VisibilityNotifier2D = get_node_or_null(visibility_notifier)
		if !vn:
			printerr("BehaviorTree: must have valid visibility notifier (if set)")
			errors = true
		else:
			vn.connect("screen_entered", self, "_on_screen_entered")
			vn.connect("screen_exited", self, "_on_screen_exited")
	
	if errors or !_validate_children():
		print("BehaviorTree: errors encountered: behavior tree will not process")
		return

	if sync_type == SyncType.Idle:
		set_process(true)
	else:
		set_physics_process(true)


func _validate_children() -> bool:
	if get_child_count() != 1:
		printerr("BehaviorTree: exactly one child required")
		return false
	var c = get_child(0)
	if !c is BehaviorTreeNode:
		printerr("BehaviorTree: child node must be a behavior node")
		return false
	
	return true


func _process(delta: float) -> void:
	_run(delta)


func _physics_process(delta: float) -> void:
	_run(delta)


func _run(delta: float) -> void:
	var result = BehaviorTreeResult.new()
	
	var bc:BehaviorTreeNode = get_child(0)
	bc.break_on_debug()
	bc.tick(delta, _blackboard, result)


func _on_screen_entered():
	if sync_type == SyncType.Idle:
		set_process(true)
	else:
		set_physics_process(true)

func _on_screen_exited():
	set_process(false)
	set_physics_process(false)
