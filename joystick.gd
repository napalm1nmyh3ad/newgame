extends Control

signal joystick_moved(direction: Vector2)

var radius = 0
var knob_radius = 0
var is_dragging = false
var current_pos = Vector2.ZERO

func _ready():
	# Базовая настройка
	var screen_size = get_viewport_rect().size
	radius = screen_size.x * 0.15
	knob_radius = radius * 0.5
	
	# Настройка размера и позиции
	custom_minimum_size = Vector2(radius * 2, radius * 2)
	size = Vector2(radius * 2, radius * 2)
	position = Vector2(
		screen_size.x / 2 - radius,
		screen_size.y - radius * 2.5
	)
	current_pos = Vector2(radius, radius)
	
	# Делаем узел уникальным и видимым
	unique_name_in_owner = true
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	print("Joystick initialized at position: ", position)

func _draw():
	# Рисуем джойстик
	draw_circle(Vector2(radius, radius), radius, Color(0.5, 0.5, 0.5, 0.5))
	draw_circle(current_pos, knob_radius, Color(0.8, 0.8, 0.8, 0.8))

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var local_pos = get_local_mouse_position()
				var center = Vector2(radius, radius)
				if local_pos.distance_to(center) < radius:
					is_dragging = true
					_update_joystick(local_pos)
			else:
				_reset_joystick()

	elif event is InputEventMouseMotion and is_dragging:
		_update_joystick(get_local_mouse_position())

func _update_joystick(input_position):
	var center = Vector2(radius, radius)
	var direction = input_position - center
	
	if direction.length() > radius:
		direction = direction.normalized() * radius
		current_pos = center + direction
	else:
		current_pos = input_position
	
	var normalized_direction = direction.normalized()
	print("Emitting direction: ", normalized_direction)
	joystick_moved.emit(normalized_direction)
	queue_redraw()

func _reset_joystick():
	is_dragging = false
	current_pos = Vector2(radius, radius)
	print("Resetting joystick, emitting zero vector")
	joystick_moved.emit(Vector2.ZERO)
	queue_redraw()
