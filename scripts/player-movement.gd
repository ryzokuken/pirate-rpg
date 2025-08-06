extends CharacterBody2D

@export var TILE_SIZE: int = 16
@export var move_speed: float = 120.0

var target_position: Vector2
var is_moving: bool = false

func _ready():
	position = position.snapped(Vector2(TILE_SIZE, TILE_SIZE))
	position += Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)
	target_position = position

func _physics_process(delta: float):
	if position != target_position:
		is_moving = true
		position = position.move_toward(target_position, move_speed * delta)
		if position.distance_to(target_position) <= move_speed * delta:
			position = target_position
			velocity = Vector2.ZERO
	else:
		is_moving = false
		get_player_input()

func get_player_input():
	if is_moving:
		return
	
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		
	if input_direction != Vector2.ZERO:
		var next_target = position + input_direction * TILE_SIZE
		
		var result = get_world_2d().direct_space_state.intersect_ray(
			PhysicsRayQueryParameters2D.create(position, next_target)
		)

		if not result:
			print(next_target, " IS CLEAR, MOVING THERE")
			target_position = next_target
