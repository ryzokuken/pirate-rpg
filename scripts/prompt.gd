extends PanelContainer

@onready var label = $Container/Label

func update_text(text: String):
	label.text = text
