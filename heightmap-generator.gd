tool
extends ImageTexture
# member variables here, example:
export(int,1,100) var octave= 5 setget set_octave, get_octave
export(int,1,512) var width= 200 setget set_width, get_width
export(int,1,512) var height= 200 setget set_height, get_height

func _init():
	createPerlinNoise()
	
func createPerlinNoise():
	var heightmap = []
	var greyCol = rand_range(1,0)
	randomize()
	
	#Generate standard noise
	for i in range(width):
		heightmap.append([])
		for j in range(height):
			randomize()
			greyCol = rand_range(1,0)
			heightmap[i].append(greyCol)
	
	#smoothing process
	var smoothNoise=[]#an array of 2D arrays
	var perlinNoise=[]#an array of 2D arrays
	var persistance=0.5
	var amplitude = 1.0
	var totalAmplitude = 0.0
	for k in range(octave):
		smoothNoise.append(GenerateSmoothNoise(heightmap,k))
	
	#blend noise
	var octaveCount=octave
	while (octaveCount) > 0:
		octaveCount=octaveCount-1
		amplitude *= persistance
		totalAmplitude += amplitude
		for i in range(width):
			perlinNoise.append([])
			for j in range (height):
				perlinNoise[i].append(smoothNoise[octaveCount][i][j]*amplitude)
		pass
	
	#normalization
	for i in range(width):
    	var row = perlinNoise[i]
    	for j in range(height):
        	row[j] = row[j] / totalAmplitude
	
	#convert the noise to a heightmap image		
	var heightmapImage=arrayToHeightmap(perlinNoise)
	#set value of heightmap for script
	create_from_image ( heightmapImage, 0 )

#optimzation could be performed to remove this step by using the image directly instead of an array
func arrayToHeightmap(arrayMap):
	var old_min = 0
	var old_max = 1
	var new_min = 0
	var new_max = 255
	var NewRange = (new_max - new_min)  
	var OldRange = (old_max - old_min) 
	 
	var heightmap = Image( width, height, false, 0 )
	for i in range(width):
		for j in range(height):
			var old_value = arrayMap[i][j]
			var new_value = round(((((old_value - old_min) * NewRange) / OldRange) + new_min))
			heightmap.put_pixel(i,j,Color(new_value,new_value,new_value),0)
	return heightmap
	
func GenerateSmoothNoise(heightmap,octave):
	var samplePeriod = 1 << octave
	var sampleFrequency = 1.0 / samplePeriod
	var smoothNoise = []
	#Reduce the noise to smooth it
	for i in range(width):
		smoothNoise.append([])
		var sample_i0=(i/samplePeriod)*samplePeriod
		var sample_i1 = (sample_i0 + samplePeriod) % width
		var horizontal_blend = (i - sample_i0) * sampleFrequency
		for j in range(height):
			var sample_j0=(j/samplePeriod)*samplePeriod
			var sample_j1 = (sample_j0 + samplePeriod) % height
			var vertical_blend = (j - sample_j0) * sampleFrequency
			var top = Interpolate(heightmap[sample_i0][sample_j0],heightmap[sample_i1][sample_j0], horizontal_blend);
			var bottom = Interpolate(heightmap[sample_i0][sample_j1],heightmap[sample_i1][sample_j1], horizontal_blend)
			smoothNoise[i].append(Interpolate(top,bottom,vertical_blend))
	return smoothNoise

func Interpolate(x0, x1, alpha):
	return x0 * (1 - alpha) + alpha * x1
	
func get_width():
	return width
func get_height():
	return height
func get_octave():
	return octave
	
func set_height(newvalue):
	height = newvalue
	createPerlinNoise()
func set_width(newvalue):
	width = newvalue
	createPerlinNoise()
func set_octave(newvalue):
	octave = newvalue
	createPerlinNoise()
