extends PanelContainer

const ACTIONS = {
	"chest": "open",
	"crate": "open",
	"barrel": "open",
	"key": "pick",
	"map": "pick",
	"bottle": "pick",
	"weapon": "pick",
	"sailor": "talk",
	"captain": "talk",
	"merchant": "trade",
	"boat": "board",
	"door": "enter",
	"sign": "read"
}

@onready var label = $Container/Label
@onready var timer = $HideTimer

func _ready() -> void:
	hide()

func update(type: String, pos: Vector2i):
	if ACTIONS.has(type):
		timer.start()
		label.text = ACTIONS[type]
		position = Vector2(pos) - size / 4
		show()

func _on_hide_timer_timeout() -> void:
	hide()
