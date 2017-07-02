package pixeldroid.json
{

    public class YamlPrinterOptions
    {

        static public function get compact():YamlPrinterOptions
        {
            var opts:YamlPrinterOptions = new YamlPrinterOptions();

            opts.compactNestingLevel = 2;
            opts.itemSeparator = ' ';
            opts.tightLists = true;

            return opts;
        }

        static public function get standard():YamlPrinterOptions
        {
            return new YamlPrinterOptions();
        }

        public var compactNestingLevel:Number = 0;
        public var documentStart:String = '---';
        public var fieldSeparator:String = ' ';
        public var itemSeparator:String = '\n';
        public var tabSize:Number = 2;
        public var tightLists:Boolean = false;
    }
}
