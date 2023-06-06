extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://level0.tscn")
	pass # Replace with function body.

func _on_button_2_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_button_mouse_entered():
	boxMove("Button")
	pass # Replace with function body.


func _on_button_2_mouse_entered():
	boxMove("Button2")
	pass # Replace with function body.
	
func boxMove(button):
	if button == "Button":
		get_node("box").position = Vector2(525,439)
	else:
		get_node("box").position = Vector2(475,556)



