extends RigidBody2D
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	
	pass # Replace with function body.


func _process(_delta):
	
	if "RigidBody2D" in str(get_colliding_bodies()):
		$AnimatedSprite2D.play("pressed")
	else:
		$AnimatedSprite2D.play("idle")
	
	
	if "RigidBody2D" in str(get_colliding_bodies()) and not pressed:
		pressed = true
		var buttonGroup = str(self)[6]
		var doors = []
		var indicators = []
		for node in get_parent().get_children():
			if "door" in node.get_name() and str(node)[4] == buttonGroup:
				doors.append(node)
			elif "indicator" in node.get_name() and str(node)[9] == buttonGroup:
				indicators.append(node)
		print(doors)
		for door in doors:
			door.collision_layer = 2
			var doorAnimation = door.get_node("doorSprite")
			doorAnimation.play("opening")

		for indicator in indicators:
			indicator.get_node("Sprite2D").modulate = Color(1,0.7,0.18)
		
	elif "RigidBody2D" not in str(get_colliding_bodies()) and pressed == true:
		pressed = false
		var buttonGroup = str(self)[6]
		var doors = []
		var indicators = []
		for node in get_parent().get_children():
			if "door" in node.get_name() and str(node)[4] == buttonGroup:
				doors.append(node)
			elif "indicator" in node.get_name() and str(node)[9] == buttonGroup:
				indicators.append(node)
		for door in doors:
			door.collision_layer = 1
			var doorAnimation = door.get_node("doorSprite")
			doorAnimation.play("closing")

		for indicator in indicators:
			indicator.get_node("Sprite2D").modulate = Color(0,1,1)
