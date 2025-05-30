extends Camera2D

var scroll_speed = 800  # pixels per second

var drag_pos = Vector2.ZERO
var dragging: bool

@export var ZOOM_MIN = 0.4
@export var ZOOM_MAX = 2.5

func _process(delta):
	var Main = get_parent()
	
	var new_pos = position
	
	var input_vector = Vector2.ZERO # lets a vector and gives it direction based on input from the user
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized() # noramlises the values, and applies them to position
	new_pos += input_vector * scroll_speed * delta / zoom.x
	
	var mouse_pos = get_viewport().get_mouse_position() # gets the mouse position in the viewport

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT): # sets dragging boolean, also sets drag origin
		if not dragging:
			drag_pos = mouse_pos
		dragging = true

	elif not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		dragging = false
			
	if dragging: # applies position change if draggingand incrementally resets drag origin
		new_pos += (drag_pos - mouse_pos) / zoom.x
		drag_pos = mouse_pos
	
	
	
	#at the end of frame makes sure that the viewport doesn't exit the usable frame using a buffer
	var buffer = get_viewport().size.x / zoom.x / 32
	position.x = max(get_viewport().size.x / zoom.x / 2 - buffer, min(new_pos.x, Main.row_cols.x * 120 - get_viewport().size.x / 2 / zoom.x + buffer))
	position.y = max(get_viewport().size.y / zoom.y / 2 - buffer, min(new_pos.y, Main.row_cols.y * 120 - get_viewport().size.y / 2 / zoom.y + buffer))
	
	
	
func _input(event):
	var changed_zoom = zoom
	if event is InputEventMouseButton: #changes zoom based on scroll
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			changed_zoom = changed_zoom * 1.1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			changed_zoom = changed_zoom * 0.9
	
	if changed_zoom.x > ZOOM_MIN and changed_zoom.x < ZOOM_MAX:
		zoom = changed_zoom
