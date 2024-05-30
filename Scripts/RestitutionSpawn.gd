# Variablen die getestet oder verändert werden können:
# exitTime - reguliert die Dauer bis die Szene endet und der export passiert
# spawnrate - reguliert die Dauer bis zu dem Erstellen des nächsten Cubes
extends Spatial

#Identifier for air and ground spawning separated, not necessary, but doesn't make a difference
var TopNumber = 0
var BottomNumber = 0

var timer = Timer.new()
var timer2 = Timer.new()

var exported = false;

var spawnrate = 0.15

func _ready():  # Runs when scene is initialized
	
	PositionAndCollision.sceneName = "Restitution"
	PositionAndCollision.spawnRate = "/Spawnrate_" + str(spawnrate)
	PositionAndCollision.exitTime = 40

	# Set timer interval
	timer.set_wait_time(spawnrate)

	# Set it as repeat
	timer.set_one_shot(false)

	# Connect its timeout signal to the function you want to repeat
	timer.connect("timeout", self, "_createcubeBottom")

	# Add to the tree as child of the current node
	add_child(timer)

	timer.start()
	
	# Set timer interval
	timer2.set_wait_time(spawnrate)

	# Set it as repeat
	timer2.set_one_shot(false)

	# Connect its timeout signal to the function you want to repeat
	timer2.connect("timeout", self, "_createcubeTop")

	# Add to the tree as child of the current node
	add_child(timer2)

	timer2.start()
	
	set_physics_process(true)
	
func _process(delta):
	
	if(OS.get_ticks_msec()*0.001 >= PositionAndCollision.exitTime && exported == false):
		
		exported = true
		
		timer.set_paused(true)
		timer2.set_paused(true)
	
func _createcubeBottom():
	
	# Preloads script to be attached
	var my_script = load("res://Scripts/TextToFileTest.gd")
	
	# STEP 1: add a cube to the scene
		# Create a Physics body.
	var cube = RigidBody.new()
	
	cube.name = "B_" + str(BottomNumber)
	BottomNumber = BottomNumber + 1 
	
	cube.transform.origin = Vector3(-40, 1.125, 0)  # Change initial pos
	
	# Attach script

	cube.set_script(my_script)
	
	self.add_child(cube)  # Add as a child node to self
		# Add a collision shape to the
		# Physics body, defining its shape to a Box (cube)
	var coll = CollisionShape.new()
	coll.shape = BoxShape.new()
	cube.add_child(coll)  # Add as a child node to cube
		# Add a mesh, so that it's visible
	var mesh = MeshInstance.new()
	mesh.mesh = CubeMesh.new()
	cube.add_child(mesh)  # Add as a child to cube

		# Get material from cube
	var cube_material = mesh.get_surface_material(0)
	
	
func _createcubeTop():
	
		# Preloads script to be attached
	var my_script = load("res://Scripts/TextToFile.gd")
	
	# Add a cube to the scene
		# Create a Physics body.
	var cube = RigidBody.new()

	
	cube.name = "T_" + str(TopNumber) # Add Identifier to Cubes
	TopNumber = TopNumber + 1

	cube.transform.origin = Vector3(100, 40, 0)  # change initial pos
	cube.angular_damp = 0.05
	cube.linear_damp = 0.01
	
	# Attach script
	cube.set_script(my_script)
	
	self.add_child(cube)  # Add as a child node to self
		# Add a collision shape to the
		# Physics body, defining its shape to a Box (cube)
	var coll = CollisionShape.new()
	coll.shape = BoxShape.new()
	cube.add_child(coll)  # Add as a child node to cube
		# Add a mesh, so that it's visible
	var mesh = MeshInstance.new()
	mesh.mesh = CubeMesh.new()
	cube.add_child(mesh)  # Add as a child to cube

		# Get material from cube
	var cube_material = mesh.get_surface_material(0)
