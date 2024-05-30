# Variablen die getestet oder verändert werden können:
# exitTime - reguliert die Dauer bis die Szene endet und der export passiert
extends Spatial

#Identifier
var cubeNumber = 0

var exported = false

func _ready():  # Runs when scene is initialized

	PositionAndCollision.sceneName = "FullRoomSmall"
	PositionAndCollision.spawnRate = ""
	PositionAndCollision.exitTime = 10
	
	_createCube()
	
func _process(delta):
	
	if(OS.get_ticks_msec()*0.001 >= PositionAndCollision.exitTime && exported == false):
		
		exported = true
		
func _createCube():
	
	for n in 5:
		
		# Preloads script to be attached
		var my_script = load("res://Scripts/TextToFile.gd")
		
		# Add a cube to the scene
		var cube = RigidBody.new()
		
		cube.name = str(cubeNumber) #Add Identifier to Cubes
		cubeNumber = cubeNumber + 1 
		
		cube.transform.origin = Vector3(0, 1.7, 0)  # Change initial pos
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
		
