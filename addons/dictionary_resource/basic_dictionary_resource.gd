class_name BasicDictionaryResource extends Resource

@export var _dict: Dictionary


func _init(seed: Dictionary) -> void:
	_dict = seed


func clear() -> void:
	_dict.clear()


# Dictionary duplicate ( bool deep=false ) const
func duplicate(deep: bool = false) -> BasicDictionaryResource:
	return BasicDictionaryResource.new(_dict.duplicate(deep))


func erase(key: Variant) -> bool:
	return _dict.erase(key)


func find_key(value: Variant) -> Variant:
	return _dict.find_key(value)


# There's no operator overrides in GDScript.
func put(key: Variant, value: Variant) -> void:
	_dict[key] = value


func get(key: Variant, default: Variant = null) -> Variant:
	return _dict.get(key, default)


func has(key: Variant) -> bool:
	return _dict.has(key)


func has_all(keys: Array[Variant]) -> bool:
	return _dict.has_all(keys)


func hash() -> int:
	return _dict.hash()


func is_empty() -> bool:
	return _dict.is_empty()


# bool is_read_only ( ) const
func is_read_only() -> bool:
	return _dict.is_read_only()


func keys() -> Array:
	return _dict.keys()


func make_read_only() -> void:
	_dict.make_read_only()


func merge(dictionary: Dictionary, overwrite: bool = false) -> void:
	return _dict.merge(dictionary, overwrite)


func size() -> int:
	return _dict.size()


func values() -> Array:
	return _dict.values()
