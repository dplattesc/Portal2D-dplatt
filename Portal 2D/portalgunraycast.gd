extends RayCast2D
var blueTimer = 0
var orangeTimer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	add_exception(get_parent().get_parent().get_node("object"))
	add_exception(get_parent().get_parent().get_node("character"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var bluePortal=get_parent().get_parent().get_node("portal")
	var orangePortal=get_parent().get_parent().get_node("portal2")
	var ghostPortal=get_parent().get_parent().get_node("portalghost")
	ghostPortal.position=get_collision_point()+Vector2(5,-5.5) +(get_collision_normal()*10)
	var ghostPortalNormal = get_collision_normal()
	var ghostPortalAngle = atan2(ghostPortalNormal.y, ghostPortalNormal.x)
	ghostPortal.rotation = ghostPortalAngle
	if Input.is_action_pressed("left_click") and blueTimer >= 20:
		closePortal(bluePortal)
		bluePortal.position = ghostPortal.position
		bluePortal.rotation = ghostPortalAngle
		openPortal(bluePortal)
		blueTimer = 0
	elif Input.is_action_pressed("right_click") and orangeTimer >= 20:
		closePortal(orangePortal)
		orangePortal.position= ghostPortal.position
		orangePortal.rotation = ghostPortalAngle
		openPortal(orangePortal)
		orangeTimer = 0
	blueTimer = blueTimer + 1 
	orangeTimer = orangeTimer + 1
	pass

func openPortal(portal):
	var PortalAnimation = portal.get_node("portalSprite")
	PortalAnimation.play("open")

func closePortal(portal):
	var portalSpriteDupe = portal.get_node("portalSprite").duplicate()
	get_tree().get_root().add_child(portalSpriteDupe)
	portalSpriteDupe.modulate = portal.modulate
	portalSpriteDupe.position = portal.position-Vector2(5,-5.5)
	portalSpriteDupe.rotation = portal.rotation+deg_to_rad(90)
	portalSpriteDupe.play("close")

	
