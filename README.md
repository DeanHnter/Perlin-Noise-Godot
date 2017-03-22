# Perlin-Noise-Godot
This project aims to create a simple script for generating heightmaps in godot.

This godot script generates a heightmap image that can be used for 2D or 3d terrains in godot. This is performed
using a translated version of the perlin noise algorithm.

The original implementation was written in Java : [Noise2D](https://github.com/Flafla2/Remote2D-Engine/blob/master/Remote2D/src/com/remote/remote2d/engine/logic/Noise2D.java)

The script, whilst fully functional could use some performance tweaks to improve the loading time within the godot game enigne. However using a seperate thread and reducing the width/height of your output image will reduce the performance requirements.

Contributions to the script are always welcome, just submit a pull-request.
