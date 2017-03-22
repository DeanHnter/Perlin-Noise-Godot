# Perlin-Noise-Godot
This project aims to create a simple script for generating heightmaps in godot.

This godot script generates a heightmap image that can be used for 2D or 3d terrains in godot. This is performed
using a translated version of the perlin noise algorithm.

The original implementation was written in Java : [Noise2D](https://github.com/Flafla2/Remote2D-Engine/blob/master/Remote2D/src/com/remote/remote2d/engine/logic/Noise2D.java)

The script, whilst fully functional could use some performance tweaks to improve the loading time within the godot game enigne. However using a seperate thread and reducing the width/height of your output image will reduce the performance requirements.

#### How to use:
Put this script somewhere in your godot project and instance the script, Once the script
has been instanced create a variable to store the result of the script (the image texture):

var heighmapGeneratorScript=load("res://Scripts/heightmap-generator.gd").new()
var imagetexture = heighmapGeneratorScript

#### Applying the heightmap:
As this script only generates the heightmap i.e doesent apply the image to a terrain another script
is required to apply the image to the terrain. I recommend [TheHX's heightmap.gd script](https://gist.github.com/TheHX/94a83dea1a0f932d5805)

#### Contributions
A special thanks to the godot forum community for their performance suggestions.

Contributions to the script are always welcome, just submit a pull-request.

#### Screenshot:
![Image of icon](https://github.com/deanhu2/Perlin-Noise-Godot/blob/master/screenshot.png)
