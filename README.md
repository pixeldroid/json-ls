json-ls
=======

JSON helpers for Loom

- [rationale](#rationale)
- [installation](#installation)
- [usage](#usage)
- [building](#building)
- [contributing](#contributing)


## rationale

Loom provides the [JSON][loom-json] class, which provides strongly typed access to values, requiring  separate accessors for every data type, and two families of these accessors for retrieving from Objects or Arrays. There are 18 basic accessors, and 2 methods for determining type.

The `Json` class in this library aims to simplify access to json data, using the `Json` class itself as the single container type, which exposes only 3 basic accessors, and 1 more for type retrieval:

- `keys` - a Dictionary of Json instances, indexed by Strings
- `items` - an Array of Json instances
- `value` - the actual data for the instance
- `type` - any basic System type, or Json
  * `Null`, `Boolean`, `Number`, `String`, `Vector`, `Dictionary`, `Json`

For comparison, the code snippets below present two ways to retrieve the second value of the nested array indexed by `r` in the following json data:

```json
{
   "key": [
      {"a":1.23, "b":45.67},
      {"x":8, "y":9},
      {"q":[1,2], "r":[3,4], "n":null}
   ],
}
```

> `json.json`

#### Using `system.JSON`

```ls
var jsonString:String = File.loadTextFile('assets/json.json');
var j:JSON = JSON.parse(jsonString);
trace(j.getArray('key').getArrayObject(2).getArray('r').getArrayNumber(1));
```

#### Using `pixeldroid.json.Json`

```ls
var jsonString:String = File.loadTextFile('assets/json.json');
var j:Json = Json.fromString(jsonString);
trace(j.keys['key'].items[2].keys['r'].items[1]);
```


### JsonPrinter

This library includes a configurable JSON pretty-printer, with three pre-defined configurations for convenience:

#### Standard

As you would find from jsonlint:

```json
{
    "array": [
        1,
        23
    ],
    "bool": true,
    "string": "one two three"
}
```

#### Compact

A tighter formatting that retains readability:

```json
{
  "array": [ 1, 23 ],
  "bool": true,
  "string": "one two three"
}
```

#### Minified

No extra whitespace:

```json
{"array":[1,23],"bool":true,"string":"one two three"}
```

### JsonDemo

see an example of using Json here:

* [JsonDemoCLI.build][JsonDemoCLI.build]
* [JsonDemoCLI.ls][JsonDemoCLI.ls]

you can compile and run the demo from the command line:

    $ rake cli


## installation

Download the library into its matching sdk folder:

    $ curl -L -o ~/.loom/sdks/sprint34/libs/Json.loomlib \
        https://github.com/pixeldroid/json-ls/releases/download/v0.0.3/Json-sprint34.loomlib

To uninstall, simply delete the file:

    $ rm ~/.loom/sdks/sprint34/libs/Json.loomlib


## usage

0. declare a reference to the Json loomlib in your `.build` file:
    *
    ```json
    "references": [
        "System",
        "Json"
    ],
    ```
0. import `pixeldroid.json.Json`
0. instantiate a new `pixeldroid.json.Json` and call the `fromString()` or `fromObject()` method on it
0. retrieve values for key / item chains as desired
0. print to formatted JSON string with JsonPrinter

```ls
var jsonString:String = File.loadTextFile('assets/json.json');
var j:Json = Json.fromString(jsonString);
trace(j.keys['key_name'].items[2].value);
```

```ls
var jsonObject:Dictionary.<String, Object> = { "bool": true, "array": [1,23], "string": "one two three" };
var j:Json = Json.fromObject(jsonObject);
trace(JsonPrinter.print(j, JsonPrinterOptions.compact));
```


## building

> first install [loomtasks][loomtasks]

### compiling

    $ rake lib:install

this will build the Json library and install it in the currently configured sdk

### running tests

    $ rake test

this will build the Json library, install it in the currently configured sdk, build the test app, and run the test app.


## contributing

Pull requests are welcome!


[loomtasks]: https://github.com/pixeldroid/loomtasks "loomtasks"
[loom-json]: http://docs.theengine.co/loom/1.1.4813/api/system/JSON.html "Loom JSON class"
[JsonDemoCLI.build]: ./cli/src/JsonDemoCLI.build "build file for the CLI demo"
[JsonDemoCLI.ls]: ./cli/src/JsonDemoCLI.ls "source file for the CLI demo"
