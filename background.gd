extends Node2D

var cell_size = 100  # Размер одной клетки сетки
var grid_color = Color(0.2, 0.2, 0.2)  # Тёмно-серый цвет
var grid_width = 50  # Количество клеток по горизонтали
var grid_height = 50  # Количество клеток по вертикали

func _draw():
	# Рисуем горизонтальные линии
	for y in range(grid_height + 1):
		var start_pos = Vector2(-grid_width * cell_size / 2, y * cell_size - grid_height * cell_size / 2)
		var end_pos = Vector2(grid_width * cell_size / 2, y * cell_size - grid_height * cell_size / 2)
		draw_line(start_pos, end_pos, grid_color)

	# Рисуем вертикальные линии
	for x in range(grid_width + 1):
		var start_pos = Vector2(x * cell_size - grid_width * cell_size / 2, -grid_height * cell_size / 2)
		var end_pos = Vector2(x * cell_size - grid_width * cell_size / 2, grid_height * cell_size / 2)
		draw_line(start_pos, end_pos, grid_color)

	# Рисуем точку в центре каждой клетки для лучшей видимости движения
	for x in range(-grid_width/2, grid_width/2):
		for y in range(-grid_height/2, grid_height/2):
			var pos = Vector2(x * cell_size, y * cell_size)
			draw_circle(pos, 3, Color(0.3, 0.3, 0.3))
