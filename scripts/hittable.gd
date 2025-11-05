class_name Hittable
extends RefCounted

func hit(r: Ray, ray_t: Interval, rec: HitRecord) -> bool:
	assert(false, "hit() must be overridden in subclasses of Hittable")
	return false
