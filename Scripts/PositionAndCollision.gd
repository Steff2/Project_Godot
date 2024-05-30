extends Node

#Array of the gathered position data for exporting
var Positions = []

#Array of the gathered collision data
var Collisions = []

var exitTime

#Every option for the path and naming
var sceneName
var spawnRate

#Needs to be changed for different testcase folders
var testCase = 3

var posDone
var colDone

var posinProgress = false
var colinProgress = false

#Exports the position data
func ExportPos():

	if(posinProgress == false):
		
		posinProgress = true
		
		for strings in Positions:
			
			var tempsplit = strings.split(" ")
			var file = File.new()
			
			if(file.file_exists("f:/MATLAB/Data/Godot/" + sceneName + spawnRate + "/Testsatz" + str(testCase) + "/data_Position_" + tempsplit[0] + ".txt")):
				file.open("f:/MATLAB/Data/Godot/" + sceneName + spawnRate + "/Testsatz" + str(testCase) + "/data_Position_" + tempsplit[0] + ".txt", File.READ_WRITE)
			else:
				file.open("f:/MATLAB/Data/Godot/" + sceneName + spawnRate + "/Testsatz" + str(testCase) + "/data_Position_" + tempsplit[0] + ".txt", File.WRITE)
			
			file.seek_end()
			file.store_line(strings)
			file.close()
			
		posDone = true
		
		if(posDone && colDone):
			get_tree().quit()
			
			
#Exports the collision data
func ExportCol():
	
	if(colinProgress == false):
		colinProgress = true
		
		var file = File.new()
		
		file.open("f:/MATLAB/Data/Godot/" + sceneName + spawnRate + "/Testsatz" + str(testCase) + "/data_Collision.txt", File.WRITE)
		
		for data in Collisions:
			
			file.store_line(data)
			
		file.close()
		
		colDone = true

		if(posDone && colDone):
			get_tree().quit()
			
