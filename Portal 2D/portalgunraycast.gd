extends RayCast2D
var blueTimer = 0
var orangeTimer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(get_parent().get_parent().get_node("object"))
	add_exception(get_parent().get_parent().get_node("character"))
	add_exception(get_parent().get_parent().get_node("button"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bluePortal=get_parent().get_parent().get_node("portal")
	var orangePortal=get_parent().get_parent().get_node("portal2")
	var ghostPortal=get_parent().get_parent().get_node("portalghost")
	ghostPortal.position=get_collision_point()+Vector2(5,-5.5) +(get_collision_normal()*5)
	var ghostPortalNormal = get_collision_normal()
	var ghostPortalAngle = atan2(ghostPortalNormal.y, ghostPortalNormal.x)
	ghostPortal.rotation = ghostPortalAngle
	if Input.is_action_pressed("left_click") and blueTimer >= 20:
		bluePortal.position = get_collision_point()+Vector2(5,-5.5)+(get_collision_normal()*5)
		var bluePortalNormal = get_collision_normal()
		var bluePortalAngle = atan2(bluePortalNormal.y, bluePortalNormal.x)
		bluePortal.rotation = bluePortalAngle
		blueTimer = 0
	elif Input.is_action_pressed("right_click") and orangeTimer >= 20:
		orangePortal.position= get_collision_point()+Vector2(5,-5.5)+(get_collision_normal()*5)
		var orangePortalNormal = get_collision_normal()
		var orangePortalAngle = atan2(orangePortalNormal.y, orangePortalNormal.x)
		orangePortal.rotation = orangePortalAngle
		orangeTimer = 0
	blueTimer = blueTimer + 1 
	orangeTimer = orangeTimer + 1
	pass
