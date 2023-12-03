@tool
class_name BasicDictionaryResource extends Resource

var _display_internal_store: bool = true:
	set(val):
		_display_internal_store = val
		# notify_property_list_changed.call_deferred()
		notify_property_list_changed()

var _store: Dictionary = {}


func _get_property_list() -> Array:
	var store_property_usage = PROPERTY_USAGE_NO_EDITOR
	if _display_internal_store:
		store_property_usage = PROPERTY_USAGE_DEFAULT

	var properties = []
	(
		properties
		. append(
			{
				"name": "_store",
				"type": TYPE_DICTIONARY,
				"usage": store_property_usage,  # See above assignment.
				"hint": PROPERTY_HINT_NONE,
			}
		)
	)
	return properties


func clear() -> void:
	_store.clear()


func duplicate(deep: bool = false) -> BasicDictionaryResource:
	var dict = BasicDictionaryResource.new()
	dict._store = _store.duplicate(deep)
	return dict


func erase(key: Variant) -> bool:
	return _store.erase(key)


func find_key(value: Variant) -> Variant:
	return _store.find_key(value)


# There's no operator overrides in GDScript.
func put(key: Variant, value: Variant) -> void:
	_store[key] = value


# why is this differnt than the array access operator
func at(key: Variant = null, default: Variant = null) -> Variant:
	return default if not _store.has(key) else _store[key]


func has(key: Variant) -> bool:
	return _store.has(key)


func has_all(keys: Array[Variant]) -> bool:
	return _store.has_all(keys)


func hash() -> int:
	return _store.hash()


func is_empty() -> bool:
	return _store.is_empty()


func is_read_only() -> bool:
	return _store.is_read_only()


func keys() -> Array:
	return _store.keys()


func get_keys() -> Array:
	return _store.keys()


func make_read_only() -> void:
	_store.make_read_only()


func merge(dictionary: Dictionary, overwrite: bool = false) -> void:
	return _store.merge(dictionary, overwrite)


func size() -> int:
	return _store.size()


func values() -> Array[Variant]:
	return _store.values()
