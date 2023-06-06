extends StaticBody2D
var currentBodies = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	print(currentBodies)
	
	pass

func _on_area_2d_body_entered(body):
	if "RigidBody2D" in str(body):
		currentBodies.append(body)
		var buttonGroup = str(self)[6]
		var doors = []
		var indicators = []
		for node in get_parent().get_children():
			if "door" in node.get_name() and str(node)[4] == buttonGroup:
				doors.append(node)
			elif "indicator" in node.get_name() and str(node)[9] == buttonGroup:
				indicators.append(node)
		print(doors)
		if currentBodies.size() == 1:
			for door in doors:
				door.collision_layer = 2
				var doorAnimation = door.get_node("doorSprite")
				doorAnimation.play("opening")
			for indicator in indicators:
				indicator.get_node("Sprite2D").modulate = Color(1,0.7,0.18)
			$AnimatedSprite2D.play("pressed")
	pass # Replace with function body.



func _on_area_2d_body_exited(body):
	print("exited:", body)
	if "RigidBody2D" in str(body):
		currentBodies.erase(body)
		var buttonGroup = str(self)[6]
		var doors = []
		var indicators = []
		for node in get_parent().get_children():
			if "door" in node.get_name() and str(node)[4] == buttonGroup:
				doors.append(node)
			elif "indicator" in node.get_name() and str(node)[9] == buttonGroup:
				indicators.append(node)
		if currentBodies.size() == 0:
			for door in doors:
				door.collision_layer = 1
				var doorAnimation = door.get_node("doorSprite")
				doorAnimation.play("closing")
			for indicator in indicators:
				indicator.get_node("Sprite2D").modulate = Color(0,1,1)
			$AnimatedSprite2D.play("idle")
	pass # Replace with function body.

