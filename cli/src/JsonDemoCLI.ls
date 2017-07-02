package
{
    import system.application.ConsoleApplication;

    import pixeldroid.json.Json;
    import pixeldroid.json.JsonPrinter;
    import pixeldroid.json.JsonPrinterOptions;
    import pixeldroid.json.YamlPrinter;
    import pixeldroid.json.YamlPrinterOptions;


    public class JsonDemoCLI extends ConsoleApplication
    {
        override public function run():void
        {
            var jsonObject:Dictionary.<String,Object> = {
                'nulls': "loom dictionaries delete null values",
                'bool': true,
                'number': 987.6543,
                'string': "aA bB cC",
                'array': [1, [23, 45], [67, 89]],
                'dictionary': { 'a': [65, 97], 'z': { 'A': 65, 'a': 97 } }
            };
            trace('\nsource:\n' +objectToString(jsonObject));

            var j:Json = Json.fromObject(jsonObject);
            printJson(j);
            printYaml(j);
        }


        private function printJson(j:Json):void
        {
            trace('\njson');
            trace('\nstandard:\n' +JsonPrinter.print(j, JsonPrinterOptions.standard));
            trace('\ncompact:\n' +JsonPrinter.print(j, JsonPrinterOptions.compact));
            trace('\nminified:\n' +JsonPrinter.print(j, JsonPrinterOptions.minified));
        }

        private function printYaml(j:Json):void
        {
            trace('\nyaml');
            trace('\nstandard:\n' +YamlPrinter.print(j, YamlPrinterOptions.standard));
            trace('\ncompact:\n' +YamlPrinter.print(j, YamlPrinterOptions.compact));
        }


        private function objectToString(o:Object):String
        {
            // this simplified implementation assumes dictionaries are <String,Object> tuples
            var s:String;

            switch (o.getFullTypeName())
            {
                case 'system.Null' : s = 'null'; break;
                case 'system.Boolean' : s = o.toString(); break;
                case 'system.Number' : s = o.toString(); break;
                case 'system.String' : s = '"' + o.toString() + '"'; break;
                case 'system.Vector' : s = vectorToString(o as Vector.<Object>); break;
                case 'system.Dictionary' : s = dictionaryToString(o as Dictionary.<String,Object>); break;
                default: s = o.toString();
            }

            return s;
        }

        private function dictionaryToString(d:Dictionary.<String,Object>):String
        {
            var l:Vector.<String> = [];

            for (var k:String in d)
                l.push('"' +k +'": ' +objectToString(d[k]));

            return '{ ' +l.join(', ') +' }';
        }

        private function vectorToString(v:Vector.<Object>):String
        {
            var l:Vector.<String> = [];

            for each(var o:Object in v)
                l.push(objectToString(o));

            return '[ ' +l.join(', ') +' ]';
        }
    }
}
