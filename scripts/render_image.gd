extends Node

class_name RenderImage

func _ready() -> void:
	var world: HittableList = HittableList.new()
	
	var material_ground: Lambertian = Lambertian.new(RtxColor.new(0.8, 0.8, 0.0))
	var material_center: Lambertian = Lambertian.new(RtxColor.new(0.1, 0.2, 0.5))
	var material_left: Metal = Metal.new(RtxColor.new(0.8, 0.8, 0.8), 0.3)
	var material_right: Metal = Metal.new(RtxColor.new(0.8, 0.6, 0.2), 1.0)

	world.add(Sphere.new(Vec3.new(0, -100.5, -1), 100, material_ground))
	world.add(Sphere.new(Vec3.new(0, 0, -1), 0.5, material_center))
	world.add(Sphere.new(Vec3.new(-1, 0, -1), 0.5, material_left))
	world.add(Sphere.new(Vec3.new(1, 0, -1), 0.5, material_right))

	#world.add(Sphere.new(Vec3.new(0, 0, -1), 0.5))
	#world.add(Sphere.new(Vec3.new(0, -100.5, -1), 100))

	var camera: RtxCamera = RtxCamera.new()
	camera.aspect_ratio = 16.0 / 9.0
	camera.image_width = 400
	camera.samples_per_pixel = 100
	camera.max_depth = 50
	camera.render(world)

	print("\rdone")
