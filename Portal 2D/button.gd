extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	add_collision_exception_with(get_node("TileMapDefault"))
	
	pass # Replace with function body.


func _process(_delta):
	print(get_colliding_bodies().size())
	if "RigidBody2D" in str(get_colliding_bodies()):
		$AnimatedSprite2D.play("pressed")
	else:
		$AnimatedSprite2D.play("idle")
	
		
		
func _on_area_2d_area_entered(area):
	if get_colliding_bodies().size() == 1:
		var buttonGroup = str(self)[6]
		var doorName = "door"+buttonGroup
		var door = get_parent().get_node(doorName)
		var doorAnimation = door.get_node("doorSprite")
		var doorCollision = door.get_node("CollisionShape2D")
		print(doorCollision)
		door.collision_layer = 2
		doorAnimation.play("opening")
	


func _on_area_2d_area_exited(area):
	
	if get_colliding_bodies().size() == 1:
		var buttonGroup = str(self)[6]
		var doorName = "door"+buttonGroup
		var door = get_parent().get_node(doorName)
		var doorAnimation = door.get_node("doorSprite")
		var doorCollision = door.get_node("CollisionShape2D")
		door.collision_layer = 1
		doorAnimation.play("closing")
		pass # Replace with function body.
