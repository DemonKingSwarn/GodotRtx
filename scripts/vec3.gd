class_name Vec3
extends RefCounted

var e = [0.0, 0.0, 0.0]

func _init(e0: float = 0.0, e1: float = 0.0, e2: float = 0.0) -> void:
	e[0] = e0
	e[1] = e1
	e[2] = e2

func x() -> float:
	return e[0]

func y() -> float:
	return e[1]

func z() -> float:
	return e[2]

func negate() -> Vec3:
	return Vec3.new(-e[0], -e[1], -e[2])

func add(v: Vec3) -> void:
	e[0] += v.e[0]
	e[1] += v.e[1]
	e[2] += v.e[2]

func multiply_in_place(t: float) -> void:
	e[0] *= t
	e[1] *= t
	e[2] *= t

func divide_in_place(t: float) -> void:
	multiply_in_place(1.0 / t)

func length() -> float:
	return sqrt(length_squared())

func length_squared() -> float:
	return e[0]*e[0] + e[1]*e[1] + e[2]*e[2]

static func add_vectors(u: Vec3, v: Vec3) -> Vec3:
	return Vec3.new(u.e[0] + v.e[0], u.e[1] + v.e[1], u.e[2] + v.e[2])

static func subtract_vectors(u: Vec3, v: Vec3) -> Vec3:
	return Vec3.new(u.e[0] - v.e[0], u.e[1] - v.e[1], u.e[2] - v.e[2])

static func multiply_vectors(u: Vec3, v: Vec3) -> Vec3:
	return Vec3.new(u.e[0] * v.e[0], u.e[1] * v.e[1], u.e[2] * v.e[2])

static func multiply_scalar(t: float, v: Vec3) -> Vec3:
	return Vec3.new(t * v.e[0], t * v.e[1], t * v.e[2])

static func divide_scalar(v: Vec3, t: float) -> Vec3:
	return multiply_scalar(1.0 / t, v)

static func dot(u: Vec3, v: Vec3) -> float:
	return u.e[0] * v.e[0] + u.e[1] * v.e[1] + u.e[2] * v.e[2]

static func cross(u: Vec3, v: Vec3) -> Vec3:
	return Vec3.new(
		u.e[1] * v.e[2] - u.e[2] * v.e[1],
		u.e[2] * v.e[0] - u.e[0] * v.e[2],
		u.e[0] * v.e[1] - u.e[1] * v.e[0]
	)

static func unit_vector(v: Vec3) -> Vec3:
	var length = v.length()
	if length == 0:
		return Vec3.new()
	return divide_scalar(v, length)

static func random_unit_vector() -> Vec3:
	while(true):
		var p = random_min_max(-1.0, 1.0)
		var lensq = p.length_squared()
		if (1e-160 < lensq) and (lensq <= 1.0):
			return divide_scalar(p, sqrt(p.length_squared()))

	return Vec3.new()

static func random() -> Vec3:
	return Vec3.new(
		Constants.random_double(),
		Constants.random_double(),
		Constants.random_double()
	)

static func random_min_max(min: float, max: float) -> Vec3:
	return Vec3.new(
		randf_range(min, max),
		randf_range(min, max),
		randf_range(min, max)
	)

static func random_on_hemisphere(normal: Vec3) -> Vec3:
	var on_unit_sphere = random_unit_vector()
	if Vec3.dot(on_unit_sphere, normal) > 0.0:
		return on_unit_sphere
	else:
		return on_unit_sphere.negate()

func near_zero() -> bool:
	var s = 1e-8
	return (abs(e[0]) < s) and (abs(e[1]) < s) and (abs(e[2]) < s)

static func reflect(v: Vec3, n: Vec3) -> Vec3:
	return Vec3.subtract_vectors(v, Vec3.multiply_scalar(2.0 * Vec3.dot(v, n), n))
