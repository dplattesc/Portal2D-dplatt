extends RayCast2D
var blueTimer = 0
var orangeTimer = 0
func _ready():
	add_exception(get_parent().get_parent().get_node("object"))
	if scene_file_path == "res://end.tscn" or scene_file_path == "res://level3.tscn":
		add_exception(get_parent().get_parent().get_node("object2"))
		add_exception(get_parent().get_parent().get_node("object3"))
	add_exception(get_parent().get_parent().get_node("character"))
	pass 

func _process(_delta):
	var bluePortal=get_parent().get_parent().get_node("portal")
	var orangePortal=get_parent().get_parent().get_node("portal2")
	var ghostPortal=get_parent().get_parent().get_node("portalghost")
	var tileMapBlack = get_parent().get_parent().get_node("TileMapBlack")
	var glow = get_parent().get_parent().get_node("character").get_node("Sprite2D")
	ghostPortal.position=get_collision_point()+Vector2(5,-5.5) +(get_collision_normal()*10)
	var ghostPortalNormal = get_collision_normal()
	var ghostPortalAngle = atan2(ghostPortalNormal.y, ghostPortalNormal.x)
	ghostPortal.rotation = ghostPortalAngle
	var noTouchObjects = ["grill","door","button"]
	var blackPos = tileMapBlack.local_to_map(get_collision_point())
	if rad_to_deg(ghostPortalAngle) == 180:
		blackPos += Vector2i(1,0)
	elif rad_to_deg(ghostPortalAngle) == 90:
		blackPos += Vector2i(0,-1)
	#stupid bugfix thing
	#get_parent().get_parent().get_node("object").position = tileMapBlack.map_to_local(blackPos)
	for nono in noTouchObjects:
		if nono in str(get_collider()):
			ghostPortal.get_node("Sprite2D").modulate = Color(1,0,0)
			return
		else:
			ghostPortal.get_node("Sprite2D").modulate = Color(0,1,0)
	var overlappingTile = tileMapBlack.get_cell_source_id(1, Vector2i(blackPos))
	if overlappingTile != -1:
		ghostPortal.get_node("Sprite2D").modulate = Color(1,0,0)
		return
	else:
		ghostPortal.get_node("Sprite2D").modulate = Color(0,1,0)



	if Input.is_action_pressed("left_click") and blueTimer >= 20:
		closePortal(bluePortal)
		bluePortal.position = ghostPortal.position
		bluePortal.rotation = ghostPortalAngle
		openPortal(bluePortal)
		glow.modulate = Color(0,1,1)
		blueTimer = 0
	elif Input.is_action_pressed("right_click") and orangeTimer >= 20:
		closePortal(orangePortal)
		orangePortal.position= ghostPortal.position
		orangePortal.rotation = ghostPortalAngle
		openPortal(orangePortal)
		glow.modulate = Color(1,0.7,0.18)
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

	
