@tool
class_name DictionaryResource extends BasicDictionaryResource

# Dictionary of strings to the type of its value
var type_hints: TypeHintResource:
	set(val):
		type_hints = val
		notify_property_list_changed()

var _display_type_hints := true
var _display_internal_store_toggle := false  # debug true


func _init() -> void:
	# By default, BasicDictionaryResource shows it's internal dictionary. Disable it.
	self._display_internal_store = false


func _get_property_list() -> Array:
	var properties: Array = [
		{
			"name": "Type Hints",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_CATEGORY if _display_type_hints else PROPERTY_USAGE_NO_EDITOR,
		},
		{
			"name": "type_hints",
			"type": TYPE_OBJECT,
			"value": type_hints,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "TypeHintResource",
			"usage": PROPERTY_USAGE_DEFAULT if _display_type_hints else PROPERTY_USAGE_NO_EDITOR,
		},
		{
			"name": "_display_internal_store",
			"type": TYPE_BOOL,
			"hint": PROPERTY_HINT_NONE,
			"usage":
			PROPERTY_USAGE_DEFAULT if _display_internal_store_toggle else PROPERTY_USAGE_NO_EDITOR,
		},
		{
			"name": "Dictionary Resource Value",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_NONE,
			"usage": PROPERTY_USAGE_CATEGORY,
		},
	]

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
	var default_value = type_hints.at(typename)
	var type: int = typeof(default_value)
	var val: Variant = self.at(typename, default_value)

	var hint_type := PROPERTY_HINT_NONE
	var hint_string := ""

	if val is Array:
		hint_type = PROPERTY_HINT_ARRAY_TYPE
		hint_string = "DictionaryResource"
	if val is DictionaryResource:
		hint_type = PROPERTY_HINT_ENUM
		hint_string = "DictionaryResource"

	return {
		"name": typename,
		"type": type,
		"value": val,
		"hint": hint_type,
		"hint_string": hint_string,
		"usage": PROPERTY_USAGE_EDITOR,
	}


func _set(prop_name: StringName, val: Variant) -> bool:
	if prop_name == "_display_internal_store":
		_display_internal_store = val
		notify_property_list_changed()
	elif prop_name == "type_hints":
		type_hints = val
		notify_property_list_changed()
	else:
		if val is Array:
			var nested_hints = type_hints.at(prop_name)[0]
			if not nested_hints is TypeHintResource:
				push_error("Expected TypeHintResource for %s, but got : " % prop_name, nested_hints)
				return false
			for v in val:
				if not v is DictionaryResource:
					continue
				v.type_hints = nested_hints
				v._display_type_hints = false
				v._display_internal_store = false
				v._display_internal_store_toggle = false
		if val is DictionaryResource:
			var nested_hints = type_hints.at(prop_name)
			if not nested_hints is TypeHintResource:
				push_error("Expected TypeHintResource for %s, but got : " % prop_name, nested_hints)
				return false
			val._display_type_hints = false
			val._display_internal_store = false
			val._display_internal_store_toggle = false
			val.type_hints = nested_hints

		self.put(prop_name, val)

	return true


func _get(prop_name: StringName) -> Variant:
	if prop_name == "_display_internal_store":
		return _display_internal_store
	if prop_name == "type_hints":
		return type_hints

	# return dictionary val
	return self.at(prop_name)
