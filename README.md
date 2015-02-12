json-ls
=======

JSON helpers for Loom


## installation

Download the library into its matching sdk folder:

    $ curl -L -o ~/.loom/sdks/sprint33/libs/Json.loomlib \
        https://github.com/pixeldroid/json-ls/releases/download/v0.0.1/Json-sprint33.loomlib

To uninstall, simply delete the file:

    $ rm ~/.loom/sdks/sprint33/libs/Json.loomlib


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

* [JsonDemo.build][JsonDemo.build]
* [JsonDemo.ls][JsonDemo.ls]

you can compile and run the demo from the command line:

    $ rake demo:gui

## working from source

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
[JsonDemo.build]: ./test/src/JsonDemo.build "build file for the demo"
[JsonDemo.ls]: ./test/src/JsonDemo.ls "source file for the demo"
