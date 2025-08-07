extends Node2D

@onready var menu = $Menu

func _ready() -> void:
	menu.connect("toggle_pause", toggle_pause)

func toggle_pause():
	var tree = get_tree()
	if menu.visible and tree.paused:
		tree.paused = false
		menu.hide()
	else:
		tree.paused = true
		menu.show()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func act_tile(type: String, data: TileData) -> void:
	if type == "crate" or type == "chest" or type == "barrel":
		print("BAG", data)
