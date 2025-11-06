extends RtxMaterial
class_name Lambertian

var albedo: RtxColor

func _init(albedo: RtxColor) -> void:
	self.albedo = albedo

func scatter(r_in: Ray, rec: HitRecord, attenuation: RtxColor, scattered: Ray) -> bool:
	var scatter_direction = Vec3.add_vectors(rec.normal, Vec3.random_unit_vector())
	
	if scatter_direction.near_zero():
		scatter_direction = rec.normal

	scattered = Ray.new(rec.p, scatter_direction)
	attenuation.e[0] = albedo.e[0]
	attenuation.e[1] = albedo.e[1]
	attenuation.e[2] = albedo.e[2]
	return true
