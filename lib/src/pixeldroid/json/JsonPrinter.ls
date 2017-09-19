package pixeldroid.json
{

    import pixeldroid.json.Json;
    import pixeldroid.json.JsonPrinterOptions;

    public class JsonPrinter
    {

        static public function print(json:Json, options:JsonPrinterOptions = null, indentLevel:Number = 0):String
        {
            if (options == null) options = JsonPrinterOptions.standard;
            var s:String;

            switch (json.type.getFullName())
            {
                //   'system.Null' : loom dictionaries delete any keys with values set to null
                case 'system.Boolean' : s = json.value.toString(); break;
                case 'system.Number' : s = json.value.toString(); break;
                case 'system.String' : s = stringToJsonString(json.value.toString()); break;
                case 'system.Vector' : s = vectorToJsonString(options, json.items, indentLevel); break;
                case 'system.Dictionary' : s = dictionaryToJsonString(options, json.keys, indentLevel); break;
            }

            return s;
        }


        static private function indent(level:Number, tabSize:Number, char:String = ' '):String
        {
            var s:String = '';
            var n:Number = level * tabSize;

            while (n > 0) {
                s += char;
                n--;
            }

            return s;
        }

        static private function stringToJsonString(s:String):String
        {
            var result:String = s;

            result = result.split('\\').join('\\\\'); // expand backslash before others

            result = result.split('"').join('\\"');
            result = result.split('\b').join('\\b');
            result = result.split('\f').join('\\f');
            result = result.split('\n').join('\\n');
            result = result.split('\r').join('\\r');
            result = result.split('\t').join('\\t');
            // result = result.split('\u').join('\\u'); // FIXME: need to match \uXXXX (u+4)

            return '"' +result +'"';
        }

        static private function containerToJsonString(options:JsonPrinterOptions, items:Vector.<Object>, indentLevel:Number, openBrace:String, closeBrace:String):String
        {
            var s:String;
            var bookend:String;
            var currentIndent:String = indent(indentLevel, options.tabSize);
            var nextIndent:String = indent(indentLevel + 1, options.tabSize);

            s = items.join(',' + options.fieldSeparator);

            if (s.length <= options.allowableLineLength)
            {
                bookend = (items.length > 0) ? options.fieldSeparator : '';
                s = openBrace + bookend + s + bookend + closeBrace;
            }
            else
            {
                bookend = (items.length > 0) ? options.containerBookend : '';
                s = nextIndent + items.join(',' + options.itemSeparator + nextIndent);
                s = openBrace + bookend + s + bookend + currentIndent + closeBrace;
            }

            return s;
        }

        static private function dictionaryToJsonString(options:JsonPrinterOptions, d:Dictionary.<String, Json>, indentLevel:Number):String
        {
            var key:String;

            var k:Vector.<String> = [];
            for (key in d) k.push(key);
            k.sort();

            var items:Vector.<Object> = [];
            var n:Number = k.length;
            var s:String;
            var val:Json;

            for (var i:Number = 0; i < n; i++)
            {
                key = k[i];
                val = d[key];
                s = '"' + key + '":' + options.fieldSeparator + print(val, options, indentLevel + 1);
                items.push(s);
            }

            return containerToJsonString(options, items, indentLevel, '{', '}');
        }

        static private function vectorToJsonString(options:JsonPrinterOptions, v:Vector.<Json>, indentLevel:Number):String
        {
            var items:Vector.<Object> = [];
            var n:Number = v.length;
            var s:String;
            var val:Json;

            for (var i:Number = 0; i < n; i++)
            {
                val = v[i];
                s = print(val, options, indentLevel + 1);
                items.push(s);
            }

            return containerToJsonString(options, items, indentLevel, '[', ']');
        }
    }
}
