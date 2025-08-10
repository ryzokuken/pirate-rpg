extends Node2D

@onready var menu = $Menu

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		menu.pause()

func act_tile(type: String, location: Vector2) -> void:
	if type == "crate" or type == "chest" or type == "barrel":
		print("OPEN INVENTORY ", type, location)
	elif type == "door":
		print("TELEPORTING ", location)
	elif type == "sign":
		print("MESSAGE FROM ", location)
