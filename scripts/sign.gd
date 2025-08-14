extends CanvasLayer

@onready var label = $Container/Label
@onready var timer = $HideTimer

const data = {
	Vector2i(25, -11): "Havana Sailors Market",
	Vector2i(37, -11): "Havana Governors Mansion",
	Vector2i(42, -13): "Enrico Rodriguez Calvar",
}

func _ready() -> void:
	hide()

func update(location: Vector2i):
	if data.has(location):
		timer.start()
		label.text = data[location]
		show()
	else:
		print(location)

func _on_hide_timer_timeout() -> void:
	hide()
