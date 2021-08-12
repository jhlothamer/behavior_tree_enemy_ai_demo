extends AnimatedSprite

onready var _tween: Tween = $Tween

func _ready():
	frame = 0
	playing = true
	_tween.interpolate_property(self, "scale", Vector2.ONE, Vector2(.2, .2), 1.0)
	_tween.start()
