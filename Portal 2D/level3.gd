extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var character = get_node("character")
	var winBox = get_node("winbox")
	if character in winBox.get_overlapping_bodies():
		get_tree().change_scene_to_file("res://end.tscn")
		self.free()
