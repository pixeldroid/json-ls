package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.json.Json;
    import pixeldroid.json.YamlPrinter;
    import pixeldroid.json.YamlPrinterOptions;


    public static class YamlPrinterSpec
    {
        private static var it:Thing;
        private static var json:Json;

        public static function specify(specifier:Spec):void
        {
            it = specifier.describe('YamlPrinter');
            var jsonFile:String = 'fixtures/json.json';
            var jsonString:String = File.loadTextFile(jsonFile);

            json = Json.fromString(jsonString);

            // validation of the YAML itself is not testable here until a loom YAML parser is available
            // in the meantime, output is manually validated with the following linters:
            //   https://codebeautify.org/yaml-validator
            //   http://www.yamllint.com/

            it.should('default to standard formatting options', default_to_standard_formatting);
        }


        private static function default_to_standard_formatting():void
        {
            var prettyString:String = YamlPrinter.print(json);
            var standard:String = YamlPrinter.print(json, YamlPrinterOptions.standard);

            it.expects(prettyString == standard).toBeTruthy();
            // it.expects(prettyString).toEqual(standard);
            //  ^ this format would generally be preferred,
            //    but will print the full strings to the log,
            //    so we use a more basic assertion instead
        }

    }
}
