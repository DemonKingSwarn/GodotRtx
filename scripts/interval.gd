class_name Interval

var min: float
var max: float

static var infinity := INF
static var empty := Interval.new(infinity, -infinity)
static var universe := Interval.new(-infinity, infinity)

func _init(min_val: float = infinity, max_val: float = -infinity) -> void:
	min = min_val
	max = max_val

func size() -> float:
	return max - min

func contains(x: float) -> bool:
	return min <= x and x <= max

func surrounds(x: float) -> bool:
	return min < x and x < max

func clamp(x: float) -> float:
	return clampf(x, min, max)
