extends Hittable
class_name Sphere

var center: Vec3
var radius: float

var material: RtxMaterial

const HitRecord = preload("res://scripts/hit_record.gd")

func _init(cent: Vec3, rad: float, mat: RtxMaterial) -> void:
	center = cent
	radius = rad
	material = mat

func hit(r: Ray, ray_t: Interval, rec: HitRecord) -> bool:
	var oc = Vec3.subtract_vectors(self.center, r.origin())
	var a = r.direction().length_squared()
	var h = Vec3.dot(r.direction(), oc)
	var c = oc.length_squared() - (self.radius * self.radius)

	var discriminant = h * h - a * c
	if discriminant < 0:
		return false

	var sqrtd = sqrt(discriminant)

	var root = (h - sqrtd) / a
	if (!ray_t.surrounds(root)):
		root = (h + sqrtd) / a
		if (!ray_t.surrounds(root)):
			return false

	rec.t = root
	rec.p = r.at(rec.t)
	var outward_normal = Vec3.divide_scalar(Vec3.subtract_vectors(rec.p, center), radius)
	rec.set_face_normal(r, outward_normal)
	rec.mat = material
	#rec.normal = Vec3.divide_scalar(Vec3.subtract_vectors(rec.p, center), radius)

	return true
