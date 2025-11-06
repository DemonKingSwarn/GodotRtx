class_name HitRecord

var p: Vec3
var normal: Vec3
var mat: RtxMaterial
var t: float
var front_face: bool

func set_face_normal(r: Ray, outward_normal: Vec3) -> void:
	front_face = Vec3.dot(r.direction(), outward_normal) < 0
	normal = outward_normal if front_face else outward_normal.negate()

