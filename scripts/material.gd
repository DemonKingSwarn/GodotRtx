extends RefCounted
class_name RtxMaterial

func _init() -> void:
	pass

func scatter(r_in: Ray, rec: HitRecord, attenuation: RtxColor, scattered: Ray) -> bool:
	return false
