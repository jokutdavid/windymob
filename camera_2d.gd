extends Camera2D

var scroll_speed = 400  # pixels per second

var drag_pos = Vector2.ZERO
var dragging: bool

func _process(delta):
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()
	position += input_vector * scroll_speed * delta
	
	var mouse_pos = get_viewport().get_mouse_position()

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if not dragging:
			drag_pos = mouse_pos
		dragging = true

	elif not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		dragging = false
			
	if dragging:
		position += (drag_pos - mouse_pos) * delta * 30
		drag_pos = (drag_pos + mouse_pos) / 2
		
