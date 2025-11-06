extends Hittable
class_name HittableList

var objects: Array = []

func _init(object: Hittable = null) -> void:
	objects = []
	if object != null:
		add(object)

func clear() -> void:
	objects.clear()

func add(object: Hittable) -> void:
	objects.append(object)


func hit(r: Ray, ray_t: Interval, rec: HitRecord) -> bool:
	var temp_rec = HitRecord.new()
	var hit_anything = false
	var closest_so_far = ray_t.max

	for object in objects:
		if object.hit(r, Interval.new(ray_t.min, closest_so_far), temp_rec):
			hit_anything = true
			closest_so_far = temp_rec.t
			rec.t = temp_rec.t
			rec.p = temp_rec.p
			rec.normal = temp_rec.normal
			rec.front_face = temp_rec.front_face
			rec.mat = temp_rec.mat

	return hit_anything
