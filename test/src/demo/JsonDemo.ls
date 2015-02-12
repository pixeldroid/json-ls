
package
{

    import loom.Application;

    import pixeldroid.json.Json;
    import pixeldroid.json.JsonPrinter;
    import pixeldroid.json.JsonPrinterOptions;


    public class JsonDemo extends Application
    {
        override public function run():void
        {
            var jsonString:String = File.loadTextFile('src/assets/json.json');
            trace(jsonString);

            var jsonObject:Dictionary.<String, Object> = { "bool": true, "array": [1,23], "string": "one two three" };
            var j:Json = Json.fromObject(jsonObject);
            trace('standard:\n', JsonPrinter.print(j, JsonPrinterOptions.standard));
            trace('compact:\n', JsonPrinter.print(j, JsonPrinterOptions.compact));
            trace('minified:\n', JsonPrinter.print(j, JsonPrinterOptions.minified));
        }

    }
}
