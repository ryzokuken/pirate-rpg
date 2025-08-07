extends CanvasLayer

signal toggle_pause

func _ready() -> void:
	hide()

func _on_resume_pressed() -> void:
	emit_signal("toggle_pause")

func _on_quit_pressed() -> void:
	get_tree().quit()
