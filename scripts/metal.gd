extends RtxMaterial
class_name Metal

var albedo: RtxColor
var fuzz: float = 0.0

func _init(albedo: RtxColor, fuzz: float) -> void:
	self.albedo = albedo
	self.fuzz = min(fuzz, 1.0)

func scatter(r_in: Ray, rec: HitRecord, attenuation: RtxColor, scattered: Ray) -> bool:
	var reflected = reflect(Vec3.unit_vector(r_in.direction()), rec.normal)
	scattered = Ray.new(rec.p, reflected)
	attenuation.e[0] = albedo.e[0]
	attenuation.e[1] = albedo.e[1]
	attenuation.e[2] = albedo.e[2]
	return true

func reflect(v: Vec3, n: Vec3) -> Vec3:
	return Vec3.subtract_vectors(v, Vec3.multiply_scalar(2 * Vec3.dot(v, n), n))
