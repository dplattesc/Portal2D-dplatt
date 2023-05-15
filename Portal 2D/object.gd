extends RigidBody2D
var canTeleport = true

func lockTeleport():
	canTeleport = false
	await get_tree().create_timer(.1).timeout
	canTeleport = true


func _on_area_2d_area_entered(area):
	if canTeleport == true and area.is_in_group("portal"):
		lockTeleport()
		teleport(area)
	pass
	
func teleport(portal1):
	for portal2 in get_tree().get_nodes_in_group("portal"):
		if portal2 != portal1 and portal2.id == portal1.id:
			await get_tree().create_timer(0.01).timeout
			global_position = portal2.point.global_position
			
			var exitSpeed = max(abs(linear_velocity.x), abs(linear_velocity.y))
			linear_velocity = Vector2()
			var dir = portal2.point.global_position - portal2.global_position as Vector2
			dir = dir.normalized()
			apply_central_impulse(dir * exitSpeed)
 
