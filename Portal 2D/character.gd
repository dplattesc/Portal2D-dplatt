extends "res://object.gd"
const speed = 10
const jumpForce = -200
const friction = 0.95
var objectPickedUp: Node2D = null
var isPickedUp: bool = false
var pickTimer = 0
var dropTimer = 0
func _physics_process(delta):
	var target_position = get_global_mouse_position()
	var direction = (target_position - position).normalized()
	var motion = Vector2()
	var on_ground = onGroundRayCast()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")  #set x motion with keybinds
	if motion.length_squared() > 0: 
		motion = motion.normalized() * speed
		apply_impulse(Vector2(motion.x, 0)) #set speed
	if motion.length_squared() == 0 and on_ground: 
		linear_velocity.x *= friction #slow down character on ground
	if on_ground and Input.is_action_just_pressed("jump"): #set y motion with jump
		apply_impulse(Vector2(0, jumpForce))
	
	if isPickedUp:
		objectPickedUp.position = position + direction * 45

	if pickTimer <= 0:
		for body in get_colliding_bodies():
			if body.name == "object" or body.name == "object2" or body.name == "object3":
				objectPickedUp = body
				break
	if Input.is_action_pressed("pick_up") and not isPickedUp and objectPickedUp != null and pickTimer <= 0:
		print("pick up")
		isPickedUp = true
		objectPickedUp.get_node("CollisionShape2D").disabled = true
		dropTimer = 0.1
	elif Input.is_action_pressed("pick_up") and isPickedUp and dropTimer <= 0 and objectRayCast():
		print("drop")
		isPickedUp = false
		objectPickedUp.get_node("CollisionShape2D").disabled = false
		objectPickedUp.linear_velocity = linear_velocity 
		objectPickedUp = null
		pickTimer = 0.1
	pickTimer = max(0, pickTimer - delta)
	dropTimer = max(0, dropTimer - delta)
	
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("wipe"):
		get_tree().change_scene_to_file("res://menu.tscn")
		
	var camera = get_node("Camera2D")
	var curZoom = camera.get_zoom()
	print(curZoom)
	if Input.is_action_just_released("zoom_in") and curZoom < Vector2(3,3):
		camera.zoom = curZoom+Vector2(0.1,0.1)
	elif Input.is_action_just_released("zoom_out") and curZoom > Vector2(0.9,0.9):
		camera.zoom = curZoom-Vector2(0.1,0.1)
func onGroundRayCast():
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, 15)) #create ray query below character
	var collision = get_world_2d().direct_space_state.intersect_ray(query) #check world collision at ray query
	if get_colliding_bodies() and collision: #check for touching ground
		return true
	else:
		return false

func objectRayCast():
	var target_position = get_global_mouse_position()
	var direction = (target_position - position).normalized()
	var ray_start = objectPickedUp.position
	var ray_end = objectPickedUp.position + direction * 40
	var space_state = get_world_2d().direct_space_state
	var objectQuery = PhysicsRayQueryParameters2D.create(ray_start, ray_end)
	var objectCollision = space_state.intersect_ray(objectQuery)

	var alternativeObjectQuery = PhysicsRayQueryParameters2D.create(self.position, objectPickedUp.position)
	var alternativeObjectCollision = space_state.intersect_ray(alternativeObjectQuery)
	print(alternativeObjectCollision)
	
	
	if "TileMap" in str(objectCollision):
		return false
	elif "Body2D" in str(alternativeObjectCollision):
		return false
	else:
		return true
