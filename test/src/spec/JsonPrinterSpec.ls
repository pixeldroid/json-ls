package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.json.Json;
    import pixeldroid.json.JsonPrinter;
    import pixeldroid.json.JsonPrinterOptions;

    public static class JsonPrinterSpec
    {

        public static function describe():void
        {
            var jsonFile:String = 'fixtures/json.json';
            var jsonString:String = File.loadTextFile(jsonFile);

            var it:Thing = Spec.describe('Pretty-printed string from Json');
            var json:Json = Json.fromString(jsonString);
            var prettyString:String = JsonPrinter.print(json);

            it.should('generate a valid JSON string', function() {
                it.expects(prettyString).not.toBeNull();
                it.expects(Json.fromString(prettyString)).not.toBeNull();
            });

            it.should('generate a valid JSON string with compact formatting', function() {
                var compact:String = JsonPrinter.print(json, JsonPrinterOptions.compact);
                it.expects(Json.fromString(compact)).not.toBeNull();
            });

            it.should('generate a valid JSON string with minified formatting', function() {
                var minified:String = JsonPrinter.print(json, JsonPrinterOptions.minified);
                it.expects(Json.fromString(minified)).not.toBeNull();
            });

            it.should('default to standard formatting options', function() {
                var standard:String = JsonPrinter.print(json, JsonPrinterOptions.standard);
                it.expects(prettyString == standard).toBeTruthy();
                // it.expects(prettyString).toEqual(standard);
                //  ^ this format would generally be preferred,
                //    but will print the full strings to the log,
                //    so we use a more basic assertion instead
            });
        }

    }
}
