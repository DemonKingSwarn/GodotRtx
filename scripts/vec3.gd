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
