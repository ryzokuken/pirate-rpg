extends CanvasLayer

func _ready() -> void:
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		unpause()
		get_viewport().set_input_as_handled()

func _on_resume_pressed() -> void:
	unpause()

func _on_quit_pressed() -> void:
	get_tree().quit()

func unpause() -> void:
	assert(visible)
	get_tree().paused = false
	hide()

func pause() -> void:
	assert(!visible)
	get_tree().paused = true
	show()
