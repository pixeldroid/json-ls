package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.json.Json;
    import pixeldroid.json.JsonPrinter;
    import pixeldroid.json.JsonPrinterOptions;


    public static class JsonPrinterSpec
    {
        private static const it:Thing = Spec.describe('JsonPrinter');

        public static function describe():void
        {
            var jsonFile:String = 'fixtures/json.json';
            var jsonString:String = File.loadTextFile(jsonFile);

            json = Json.fromString(jsonString);

            it.should('generate a valid JSON string', be_valid_json);
            it.should('generate a valid JSON string with compact formatting', be_valid_when_compact);
            it.should('generate a valid JSON string with minified formatting', be_valid_when_minified);
            it.should('default to standard formatting options', default_to_standard_formatting);
        }


        private static var json:Json;

        private static function be_valid_json():void
        {
            var prettyString:String = JsonPrinter.print(json);

            it.expects(prettyString).not.toBeNull();
            it.expects(Json.fromString(prettyString)).not.toBeNull();
        }

        private static function be_valid_when_compact():void
        {
            var compact:String = JsonPrinter.print(json, JsonPrinterOptions.compact);

            it.expects(Json.fromString(compact)).not.toBeNull();
        }

        private static function be_valid_when_minified():void
        {
            var minified:String = JsonPrinter.print(json, JsonPrinterOptions.minified);

            it.expects(Json.fromString(minified)).not.toBeNull();
        }

        private static function default_to_standard_formatting():void
        {
            var prettyString:String = JsonPrinter.print(json);
            var standard:String = JsonPrinter.print(json, JsonPrinterOptions.standard);

            it.expects(prettyString == standard).toBeTruthy();
            // it.expects(prettyString).toEqual(standard);
            //  ^ this format would generally be preferred,
            //    but will print the full strings to the log,
            //    so we use a more basic assertion instead
        }

    }
}
