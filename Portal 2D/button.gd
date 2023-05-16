extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10
	pass # Replace with function body.


func _process(delta):
	if "RigidBody2D" in str(get_colliding_bodies()):
		$AnimatedSprite2D.play("pressed")
	else:
		$AnimatedSprite2D.play("idle")
		
