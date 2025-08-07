extends PanelContainer

@onready var label = $Container/Label
@onready var timer = $HideTimer

func _ready() -> void:
	hide()

func update(text: String, pos: Vector2):
	timer.start()
	label.text = text
	position = pos
	show()

func _on_hide_timer_timeout() -> void:
	hide()
