class_name Constants

const infinity = INF
const pi = 3.141592653589793

func degrees_to_radians(degrees: float) -> float:
	return degrees * pi / 180.0

func random_double() -> float:
	return randf()

func random_double_min_max(min: float, max: float) -> float:
	return min + (max - min) * random_double()
