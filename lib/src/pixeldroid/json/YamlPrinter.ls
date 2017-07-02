package pixeldroid.json
{

    import pixeldroid.json.Json;
    import pixeldroid.json.YamlPrinterOptions;

    public class YamlPrinter
    {

        static public function print(json:Json, options:YamlPrinterOptions = null, indentLevel:Number = 0):String
        {
            if (options == null) options = YamlPrinterOptions.standard;
            var s:String = options.documentStart + printItem(json, options, indentLevel);

            return s;
        }

        static public function printItem(json:Json, options:YamlPrinterOptions = null, indentLevel:Number = 0, nestingLevel:Number = 0, inList:Boolean = false):String
        {
            var s:String;

            switch (json.type.getFullName())
            {
                case 'system.Null' : s = 'null'; break;
                case 'system.Boolean' : s = json.value.toString(); break;
                case 'system.Number' : s = json.value.toString(); break;
                case 'system.String' : s = '"' + json.value + '"'; break;
                case 'system.Vector' : s = vectorToYamlString(options, json.items, indentLevel, nestingLevel, inList); break;
                case 'system.Dictionary' : s = dictionaryToYamlString(options, json.keys, indentLevel, nestingLevel, inList); break;
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

        static private function dictionaryToYamlString(options:YamlPrinterOptions, d:Dictionary.<String, Json>, indentLevel:Number, nestingLevel:Number = 0, inList:Boolean = false):String
        {
            if (d.length == 0)
                return '{}';

            var key:String;

            var k:Vector.<String> = [];
            for (key in d) k.push(key);
            k.sort();

            var compactForm:Boolean = (options.compactNestingLevel > 0) && (nestingLevel >= options.compactNestingLevel);
            var tightList:Boolean = ((inList || compactForm) && options.tightLists);
            var ind:String = indent(indentLevel, options.tabSize);
            var lines:Vector.<String> = [];
            var n:Number = k.length;
            var i:Number;
            var val:Json;

            if (compactForm)
            {
                var line:Vector.<String> = [];
                for (i = 0; i < n; i++)
                {
                    key = k[i];
                    val = d[key];
                    line.push(key + ':' + options.fieldSeparator + printItem(val, options, indentLevel + 1, nestingLevel + 1, true));
                }
                lines.push((tightList ? '' : ind) + '{ ' + line.join(',' + options.fieldSeparator) + ' }');
            }
            else
            {
                for (i = 0; i < n; i++)
                {
                    key = k[i];
                    val = d[key];
                    lines.push(((tightList && (i == 0)) ? '' : ind) + key + ':' + options.fieldSeparator + printItem(val, options, indentLevel + 1, nestingLevel + 1));
                }
            }

            return (tightList ? '' : '\n') + lines.join('\n');
        }

        static private function vectorToYamlString(options:YamlPrinterOptions, v:Vector.<Json>, indentLevel:Number, nestingLevel:Number = 0, inList:Boolean = false):String
        {
            if (v.length == 0)
                return '[]';

            var compactForm:Boolean = (options.compactNestingLevel > 0) && (nestingLevel >= options.compactNestingLevel);
            var tightList:Boolean = ((inList || compactForm) && options.tightLists);
            var ind:String = indent(indentLevel, options.tabSize);
            var lines:Vector.<String> = [];
            var n:Number = v.length;
            var i:Number;
            var val:Json;

            if (compactForm)
            {
                var line:Vector.<String> = [];
                for (i = 0; i < n; i++)
                {
                    val = v[i];
                    line.push(printItem(val, options, indentLevel + 1, nestingLevel + 1, true));
                }
                lines.push((tightList ? '' : ind) + '[ ' + line.join(',' + options.fieldSeparator) + ' ]');
            }
            else
            {
                for (i = 0; i < n; i++)
                {
                    val = v[i];
                    lines.push(((tightList && (i == 0)) ? '' : ind) + '-' + options.fieldSeparator + printItem(val, options, indentLevel + 1, nestingLevel + 1, true));
                }
            }

            return (tightList ? '' : '\n') + lines.join('\n');
        }
    }
}
