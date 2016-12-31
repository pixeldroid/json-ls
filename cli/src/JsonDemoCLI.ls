package
{
    import system.application.ConsoleApplication;

    import pixeldroid.json.Json;
    import pixeldroid.json.JsonPrinter;
    import pixeldroid.json.JsonPrinterOptions;


    public class JsonDemoCLI extends ConsoleApplication
    {
        override public function run():void
        {
            var jsonObject:Dictionary.<String,Object> = { "bool": true, "array": [1,23], "string": "aA bB cC" };
            trace('source:\n' +dictionaryToString(jsonObject));

            var j:Json = Json.fromObject(jsonObject);
            trace('standard:\n' +JsonPrinter.print(j, JsonPrinterOptions.standard));
            trace('compact:\n' +JsonPrinter.print(j, JsonPrinterOptions.compact));
            trace('minified:\n' +JsonPrinter.print(j, JsonPrinterOptions.minified));
        }

        private function dictionaryToString(d:Dictionary.<String,Object>):String
        {
            var s:String = '';

            for (var k:String in d)
            {
                s += '"' +k +'": ' +d[k].toString() +'\n';
            }

            return s;
        }
    }
}
