package pixeldroid.json
{

    public class JsonPrinterOptions
    {

        static public function get minified():JsonPrinterOptions
        {
            var opts:JsonPrinterOptions = new JsonPrinterOptions();

            opts.allowableLineLength = Number.POSITIVE_INFINITY;
            opts.containerBookend = '';
            opts.fieldSeparator = '';
            opts.itemSeparator = '';
            opts.tabSize = 0;

            return opts;
        }

        static public function get compact():JsonPrinterOptions
        {
            var opts:JsonPrinterOptions = new JsonPrinterOptions();

            opts.allowableLineLength = 40;
            opts.containerBookend = '\n';
            opts.fieldSeparator = ' ';
            opts.itemSeparator = '\n';
            opts.tabSize = 2;

            return opts;
        }

        static public function get standard():JsonPrinterOptions
        {
            return new JsonPrinterOptions();
        }

        public var allowableLineLength:Number = 0;
        public var containerBookend:String = '\n';
        public var fieldSeparator:String = ' ';
        public var itemSeparator:String = '\n';
        public var tabSize:Number = 4;
    }
}
