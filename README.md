# godot-dictionary-resource
Abstract Dictionary resource with proper typing in the editor.

# Classes
 - `BasicDictionaryResource` - Base class of all other `Dictionary` objects in this repo. The class extends `Resource` while sharing an API with Godot's `Dictionary` object.
 - `DictionaryResource` - This class provides most of the functionality for this plugin. Extends `BasicDictionaryResource` and provides the in-editor type hinting, making these dictionaries "type safe".
 - `TypeHintResource` - Alias of `BasicDictionaryResource`, used for defining type-hints for `DictionaryResource`s. Think of this as the "schema" or "structure" for your dictionary.

## Usage

### Simple
1. Create a new `TypeHintResource` to define the type-hints for your new Dictionary resource.
   **Warning**: Only key values of type  `String` are currently supported. All Godot `Variant` types(e.g. `int`, `float`, `Vector3`, etc.) are supported for values.
   **Note**: While the values in the `TypeHintResource` will be saved to its instance's resource file, the values are not used in `DictionaryResource`. Only the **types** of the values are used to inform the `DictionaryResource` which type options to display in the editor.
<img width="359" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/72a7f6c8-b9c6-44ca-9e40-0c34b4bdfc53">


2. Create a new `DictionaryResource` and load the previously made type-hints resource. Make type-safe dictionaries to your heart's content.
<img width="414" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/1288b344-98c6-48d0-8437-e656d234aa7e">
<img width="409" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/80db1562-35eb-4a00-ba2d-ba82fed542d7">


4. Use in your game!

### Nested

`TypeHintResource`s can be nested inside each other or used as the first element in an Array to provide type-hints. `TypeHintResource`s only need to be set on the top level `DictionaryResource`. 

<img width="421" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/92af9fab-7ea4-4f8b-ba7c-6c8279492da2">

The above screenshot could be converted to equivalent JSON schema of : 
```json
{
  "id": 0,
  "name": {
    "english": "blank",
    "japenese": "blank in japanese"
  }
}
```

## Full Example
The structure for Pokemon was taken from [Purukitto's repo](https://github.com/Purukitto/pokemon-data.json/blob/master/pokedex.json) to use as an example. 

The top-level structure of `PokemonTypeHints.tres` is shown here  
<img width="435" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/56c56f23-45c4-4dee-9fca-ff2e0cdcf01c">

The keys `name`, `base_stats`, and `evolution` have values that are also `TypeHintResources`:   
<img width="369" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/828c3d70-c369-4917-be1d-efd8431b6662">  
<img width="374" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/8ed8f5c7-7878-41e7-936f-65c070761e66">  
<img width="375" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/b8761a4a-e6eb-496d-9081-8cc57c2746e9">  

Opening `Bulbasaur.tres`, `Charmander.tres`, or `Squirtle.tres` will show the Editor UI this plugin provides from the schema in `PokemonTypeHints.tres`:   
| Overview | Expanded |
| --------- | ------- |
|<img width="418" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/173f4e0f-6b86-4f0f-a31d-63899a270a62"> | <img width="405" alt="image" src="https://github.com/squk/godot-dictionary-resource/assets/3443591/da34c0e7-7399-4ed2-a604-f48691fe1fd8"> |
