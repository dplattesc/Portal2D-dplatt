extends AnimatedSprite2D

var previousAnimation = ""


func _on_animation_finished():
	if animation == "open":
		play("default")
	elif animation == "close":
		queue_free()
	pass # Replace with function body.

