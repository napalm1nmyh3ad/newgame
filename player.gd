extends CharacterBody2D

var speed = 400

func _ready():
	# Устанавливаем начальную позицию игрока в центр экрана
	var screen_size = get_viewport_rect().size
	global_position = Vector2(screen_size.x / 2, screen_size.y / 2)
	
	# Подключаем джойстик
	await get_tree().process_frame
	var joystick = get_node("/root/Game/UI/Joystick")
	if joystick:
		joystick.joystick_moved.connect(func(direction): 
			velocity = direction * speed
		)

func _physics_process(_delta):
	move_and_slide()
