# Variablen die getestet oder verändert werden können:
# exportrate - reguliert der Zeit zwischen dem Sammeln von Positionsdaten 0.15 heißt 0.15 Sekunden Zeit zwischen dem Sammeln
extends RigidBody


var timer = 0

var exportrate = 0.15

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Has to be true to detect collisions
	set_contact_monitor( true )
	
	# Has to be above 0
	set_max_contacts_reported( 1000 )

	# Collision_now for when body enters another body
	connect("body_entered",self,"collision_enter")
	
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	timer -= delta
	
	#print(Performance.get_monitor(Performance.TIME_FPS))
	
	# Export positions in 0.15 second intervals
	if(timer <= 0 && OS.get_ticks_msec()*0.001 < PositionAndCollision.exitTime):
		
		timer = exportrate
		
		exporting(self.global_transform.origin)
		
	
	if(OS.get_ticks_msec()*0.001 > PositionAndCollision.exitTime && PositionAndCollision.posinProgress == false):
		
		print(OS.get_ticks_msec()*0.001)
		
		PositionAndCollision.ExportPos()
		
	if(OS.get_ticks_msec()*0.001 >= PositionAndCollision.exitTime + 1 && PositionAndCollision.colinProgress == false):
		
		PositionAndCollision.ExportCol()
#	pass

# Func to write positions
func exporting(userdata):

	PositionAndCollision.Positions.append(self.name + " " + str(userdata.x) + " " + str(userdata.y) + " " + str(userdata.z) + " " + str(OS.get_ticks_msec()*0.001))

# Thread for collision export
func collision_enter(userdata):

	if(OS.get_ticks_msec()*0.001 < PositionAndCollision.exitTime):

		PositionAndCollision.Collisions.append(self.name + " " + str(self.translation.x) + " " + str(self.translation.y) + " " + str(self.translation.z) + " " + userdata.name + " " + str(userdata.translation.x) + " " + str(userdata.translation.y) + " " + str(userdata.translation.z) + " " + str(OS.get_ticks_msec()*0.001))
	
	if(OS.get_ticks_msec()*0.001 >= PositionAndCollision.exitTime && PositionAndCollision.colinProgress == false):
		
		PositionAndCollision.ExportCol()
