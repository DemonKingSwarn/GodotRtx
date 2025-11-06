extends RefCounted

class_name Ray 

var orig: Vec3
var dir: Vec3

func _init(origin: Vec3 = null, direction: Vec3 = null) -> void:
	orig = origin if origin != null else Vec3.new()
	dir = direction if direction != null else Vec3.new()

func origin() -> Vec3:
	return orig

func direction() -> Vec3:
	return dir

func at(t: float) -> Vec3:
	var scaled_dir = Vec3.multiply_scalar(t, dir)
	return Vec3.add_vectors(orig, scaled_dir)
