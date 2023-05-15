extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var character = get_parent().get_node("character")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var target_position = get_global_mouse_position()
	var direction = (target_position - get_parent().get_node("character").position).normalized()
	var angle = direction.angle()
	rotation = angle
	position = get_parent().get_node("character").position + direction * 20
	
	if rad_to_deg(angle) < 90 and rad_to_deg(angle) > -90:
		scale.y = 1
	else:
		scale.y = -1
	pass
