extends StaticBody2D

@export var TILE_SIZE: int = 16
@export var move_speed: float = 120.0

@export var prompt: Container

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
	"boat": "board"
}

var target_position: Vector2
var is_moving: bool = false

func _ready():
	position = position.snapped(Vector2(TILE_SIZE, TILE_SIZE))
	position += Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)
	target_position = position

func _physics_process(delta: float):
	is_moving = position != target_position
	if is_moving:
		position = position.move_toward(target_position, move_speed * delta)
	else:
		get_player_input()

func get_player_input():
	if is_moving:
		return
	
	var input_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		input_direction = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		input_direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):
		input_direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		input_direction = Vector2.RIGHT
		
	if input_direction != Vector2.ZERO:
		var next_target = position + input_direction * TILE_SIZE
		var result = get_world_2d().direct_space_state.intersect_ray(
			PhysicsRayQueryParameters2D.create(position, next_target)
		)

		if result:
			var collider = result.collider
			if collider is TileMapLayer:
				var tile_coords = collider.local_to_map(next_target)
				var tile_data = collider.get_cell_tile_data(tile_coords)
				if tile_data:
					var type = tile_data.get_custom_data("type")
					if type and ACTIONS.has(type):
						prompt.update(ACTIONS[type], next_target - prompt.size / 4)
						if Input.is_action_pressed("action"):
							get_parent().act_tile(type, tile_data)
		else:
			target_position = next_target
