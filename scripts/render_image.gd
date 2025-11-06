extends Node

class_name RenderImage

func _ready() -> void:
	var world: HittableList = HittableList.new()
	world.add(Sphere.new(Vec3.new(0, 0, -1), 0.5))
	world.add(Sphere.new(Vec3.new(0, -100.5, -1), 100))

	var camera: RtxCamera = RtxCamera.new()
	camera.aspect_ratio = 16.0 / 9.0
	camera.image_width = 400
	camera.samples_per_pixel = 100
	camera.render(world)

	print("\rdone")
