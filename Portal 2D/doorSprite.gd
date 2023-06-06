extends AnimatedSprite2D


func _on_animation_finished():
	if animation == "opening":
		play("open")
	elif animation == "closing":
		play("closed")
	pass # Replace with function body.
