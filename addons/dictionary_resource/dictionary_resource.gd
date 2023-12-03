@tool
class_name DictionaryResource extends BasicDictionaryResource

# Dictionary of strings to the type of its value
var type_hints: TypeHintResource:
	set(val):
		type_hints = val
		notify_property_list_changed()


func _ready():
	# By default, BasicDictionaryResource shows it's internal dictionary. Disable it.
	self.export_store = false
	notify_property_list_changed()


func _get_property_list() -> Array:
	var properties: Array = [
		{
			"name": "Type Hints",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_CATEGORY,
		},
		{
			"name": "type_hints",
			"type": TYPE_OBJECT,
			"value": type_hints,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "TypeHintResource",
			"usage": PROPERTY_USAGE_DEFAULT,
		},
		{
			"name": "_display_internal_store",
			"type": TYPE_BOOL,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_DEFAULT,
		},
		{
			"name": "Dictionary Entries",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_CATEGORY,
		},
	]

	# hide the Dictionary normally exported by BasicDictionaryResource
	if type_hints == null:
		return properties

	for typename: Variant in type_hints.keys():
		var entry: Dictionary = build_entry(typename)
		if entry.size() > 0:
			properties.append(entry)

	return properties


func build_entry(typename: Variant) -> Dictionary:
	if not typename is String:
		push_error("Non-String keys are not supported in DictionaryResource")
		return {}
	var default_value = type_hints._store[typename]  # WTF .get doesn't work for whatever reason
	var type: int = typeof(default_value)
	var val: Variant = self.get(typename, default_value)
	return {
		"name": typename,
		"type": type,
		"value": val,
		"hint": PROPERTY_HINT_NONE,
		"usage": PROPERTY_USAGE_DEFAULT,
	}


func _set(prop_name: StringName, val: Variant) -> bool:
	if prop_name == "_display_internal_store":
		_display_internal_store - val
	elif prop_name == "type_hints":
		type_hints = val
	else:
		self.put(prop_name, val)  # already encoded w/ var_to_str

	notify_property_list_changed()
	return true


func _get(prop_name: StringName) -> Variant:
	if prop_name == "_display_internal_store":
		return _display_internal_store
	if prop_name == "type_hints":
		return type_hints

	# return dictionary val
	return self.get(prop_name)
