class_name RtxCamera

var image_width: int
var image_height: int
var aspect_ratio: float
var samples_per_pixel: int = 10
var max_depth: int = 10

var pixel_samples_scale

func render(world: HittableList) -> void:
	image_height = int(image_width / aspect_ratio)
	image_height = 1 if image_height < 1 else image_height

	pixel_samples_scale = 1.0 / samples_per_pixel

	var focal_length := 1.0
	var viewport_height := 2.0
	var viewport_width := aspect_ratio * viewport_height

	var center = Vec3.new(0, 0, 0)
	
	var viewport_u = Vec3.new(viewport_width, 0, 0)
	var viewport_v = Vec3.new(0, -viewport_height, 0)
	
	var pixel_delta_u = Vec3.divide_scalar(viewport_u, image_width)
	var pixel_delta_v = Vec3.divide_scalar(viewport_v, image_height)
	
	var focal_vec = Vec3.new(0, 0, focal_length)
	var half_viewport_u = Vec3.divide_scalar(viewport_u, 2)
	var half_viewport_v = Vec3.divide_scalar(viewport_v, 2)
	
	var temp = Vec3.subtract_vectors(center, focal_vec)
	temp = Vec3.subtract_vectors(temp, half_viewport_u)
	var viewport_upper_left = Vec3.subtract_vectors(temp, half_viewport_v)
	
	var sum_pixel_delta = Vec3.add_vectors(pixel_delta_u, pixel_delta_v)
	var half_sum = Vec3.multiply_scalar(0.5, sum_pixel_delta)
	var pixel00_loc = Vec3.add_vectors(viewport_upper_left, half_sum)

	var file := FileAccess.open("res://output.ppm", FileAccess.ModeFlags.WRITE)
	file.store_line("P3")
	file.store_line(str(image_width) + " " + str(image_height))
	file.store_line("255")

	for j in range(image_height):
		print("Scanlines remaining: " + str(image_height - j))
		for i in range(image_width):
			
			var pixel_color := RtxColor.new(0, 0, 0)
			
			for s in range(samples_per_pixel):
				if s == 0 and i == 0 and j == 0:
					print("First sample at pixel (0,0)")
				var r: Ray = get_ray(i, j, pixel00_loc, pixel_delta_u, pixel_delta_v, center)
				pixel_color = add_vectors(pixel_color, ray_color(r, max_depth, world))
			
			pixel_color = multiply_scalar(1.0 / samples_per_pixel, pixel_color)
		
			var color_string = pixel_color.write_color()
			file.store_line(color_string)

	file.close()

static func multiply_scalar(t: float, v: RtxColor) -> RtxColor:
	return RtxColor.new(t * v.e[0], t * v.e[1], t * v.e[2])

static func add_vectors(u: RtxColor, v: RtxColor) -> RtxColor:
	return RtxColor.new(u.e[0] + v.e[0], u.e[1] + v.e[1], u.e[2] + v.e[2])

func ray_color(ray: Ray, depth: int, world: Hittable) -> RtxColor:
	if depth <= 0:
		return RtxColor.new(0, 0, 0)
	var rec: HitRecord = HitRecord.new()
	if world.hit(ray, Interval.new(0.001, Constants.infinity), rec):
		var scattered: Ray = Ray.new()
		var attenuation: RtxColor = RtxColor.new()
		if rec.mat.scatter(ray, rec, attenuation, scattered):
			var new_color = ray_color(scattered, depth - 1, world)
			return RtxColor.multiply_vectors(attenuation, new_color)
		return RtxColor.new(0, 0, 0)
	var unit_direction = Vec3.unit_vector(ray.direction())
	var a = 0.5 * (unit_direction.y() + 1.0)
	return RtxColor.new((1.0 - a) + a * 0.5, (1.0 - a) + a * 0.7, 1.0)

func sample_square() -> Vec3:
	var rand_x = Constants.random_double()
	var rand_y = Constants.random_double()
	return Vec3.new(rand_x - 0.5, rand_y - 0.5, 0)

func get_ray(i: int, j: int, pixel00_loc: Vec3, pixel_delta_u: Vec3, pixel_delta_v: Vec3, origin: Vec3) -> Ray:
	var offset = sample_square()
	
	var term1 = Vec3.multiply_scalar(float(i) + offset.x(), pixel_delta_u)
	var term2 = Vec3.multiply_scalar(float(j) + offset.y(), pixel_delta_v)
	var sum1 = Vec3.add_vectors(pixel00_loc, term1)
	var pixel_sample = Vec3.add_vectors(sum1, term2)

	var ray_origin = origin
	var ray_direction = Vec3.subtract_vectors(pixel_sample, ray_origin)
	return Ray.new(ray_origin, ray_direction)
