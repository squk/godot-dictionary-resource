@tool
class_name MultiDictionaryResource extends Resource

@export var type_hints: TypeHintResource

@export var resources: Array[DictionaryResource]:
	set(val):
		resources = val
		for r in resources:
			r._display_type_hints = false
			r.type_hints = type_hints
			r.export_store = false
		notify_property_list_changed.call_deferred()
