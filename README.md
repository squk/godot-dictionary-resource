# godot-dictionary-resource
Abstract Dictionary resource with proper typing in the editor.

# Stuff n Things
 - `DictionaryResource` - This class provides most of the functionality for this plugin. `extends Resource` and provides the in-editor type hinting.  
 - `BasicDictionaryResource` - Helper class used for defining type-hints for `DictionaryResource`s.  

## Usage
1. Create a new `BasicDictionaryResource` to define the type-hints for your new Dictionary resource.  
   **Warning**: Only key values of type  `String` are currently supported. All Godot `Variant` types(e.g. `int`, `float`, `Vector3`, etc.) are supported for values.  
   **Note**: While the values in the `BasicDictionaryResource` will be saved to its instance's resource file, the values are not used in `DictionaryResource`. Only the **types** of the values are used to inform the `DictionaryResource` which type options to display in the editor.   
<img width="379" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/af843fde-9bea-4fb4-a7c9-60b6487d112a">

2. Create a new `DictionaryResource` and load the previously made type-hints. Double-click the resource to force the editor to reload it's properties. Make type-safe dictionaries to your heart's content.
<img width="384" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/09d3e497-4b27-4852-bf97-2c41f2713380">
<img width="382" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/976e2e83-6394-4f5e-8acc-37d76da99e87">

4. Use in your game!


P.S. I know these examples are bad but it's an abtract map use it for whatever
