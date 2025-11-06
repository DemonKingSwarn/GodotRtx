extends Vec3

class_name RtxColor

func _init(r := 0.0, g := 0.0, b := 0.0) -> void:
	e[0] = r
	e[1] = g
	e[2] = b

func linear_to_gamma(linear_component: float) -> float:
	if linear_component > 0:
		return sqrt(linear_component)

	return 0.0

func write_color() -> String:
	var r: float = e[0]
	var g: float = e[1]
	var b: float = e[2]

	#var rbyte := int(255.999 * r)
	#var gbyte := int(255.999 * g)
	#var bbyte := int(255.999 * b)

	# apply a linear to gamma transform for gamma 2
	r = linear_to_gamma(r)
	g = linear_to_gamma(g)
	b = linear_to_gamma(b)

	var intensity : Interval = Interval.new(0.000, 0.999)
	var rbyte := int(256 * intensity.clamp(r))
	var gbyte := int(256 * intensity.clamp(g))
	var bbyte := int(256 * intensity.clamp(b))

	return str(rbyte) + " " + str(gbyte) + " " + str(bbyte)
