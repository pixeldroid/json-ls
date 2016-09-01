package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.json.Json;

    public static class JsonSpec
    {

        public static function describe():void
        {
            var it:Thing = Spec.describe('Json');

            it.should('be versioned', function() {
                it.expects(Json.version).toPatternMatch('(%d+).(%d+).(%d+)', 3);
            });

            describeFromString();
            describeFromObject();
        }


        private static function describeFromString():void
        {
            var jsonFile:String = 'test/src/assets/json.json';
            var jsonString:String = File.loadTextFile(jsonFile);

            var it:Thing = Spec.describe('Json from String');
            var json:Json = Json.fromString(jsonString);

            it.should('initialize from a valid JSON string', function() {
                it.expects(json).not.toBeNull();
            });

            validate(it, json);
        }

        private static function describeFromObject():void
        {
            var jsonObject:Dictionary.<String, Object> = {};

            jsonObject['key_bool_true'] = true;
            jsonObject['key_bool_false'] = false;
            jsonObject['key_string'] = 'abcdefg ABCDEFG 0123_4567';
            jsonObject['key_number_integer'] = 1234;
            jsonObject['key_number_real'] = 0.9876;

            jsonObject['key_empty_array'] = [];
            jsonObject['key_array'] = ["array_1", null, "array_3"];
            jsonObject['key_nested_arrays'] = [
                [1, 2, 3],
                [[4], [5], [6], null]
            ];

            jsonObject['key_empty_object'] = {};
            jsonObject['key_object'] = {"object_1": 1, "object_2": 2, "object_3": 3};
            jsonObject['key_nested_in_object'] = {
                "nested_1": [1,2.5,3],
                "nested_2": {"a":1, "b":2, "c":{"z":"Z"}},
                "nested_3": null,
                "nested_4": true
            };

            var it:Thing = Spec.describe('Json from Object');
            var json:Json = Json.fromObject(jsonObject);

            it.should('initialize from a native Loom object', function() {
                it.expects(json).not.toBeNull();
            });

            validate(it, json);
        }

        private static function validate(it:Thing, json:Json):void
        {
            it.should('report the native Loom type each value can be extracted as', function() {
                if (json.keys['key_null']) it.expects(json.keys['key_null'].type).toEqual(Null.getType());
                it.expects(json.keys['key_bool_true'].type).toEqual(Boolean.getType());
                it.expects(json.keys['key_string'].type).toEqual(String.getType());
                it.expects(json.keys['key_number_integer'].type).toEqual(Number.getType());
                it.expects(json.keys['key_number_real'].type).toEqual(Number.getType());
                it.expects(json.keys['key_array'].type).toEqual(Vector.getType());
                it.expects(json.keys['key_object'].type).toEqual(Dictionary.getType());
            });

            it.should('retrieve native Loom values for the non-collection JSON data types', function() {
                if (json.keys['key_null']) it.expects(json.keys['key_null'].value).toBeA(Null);

                it.expects(json.keys['key_bool_true'].value).toBeA(Boolean);
                it.expects(json.keys['key_bool_true'].value).toEqual(true);

                it.expects(json.keys['key_string'].value).toBeA(String);
                it.expects(json.keys['key_string'].value).toEqual('abcdefg ABCDEFG 0123_4567');

                it.expects(json.keys['key_number_integer'].value).toBeA(Number);
                it.expects(json.keys['key_number_integer'].value).toEqual(1234);

                it.expects(json.keys['key_number_real'].value).toBeA(Number);
                it.expects(json.keys['key_number_real'].value).toEqual(0.9876);
            });

            it.should('retrieve array elements via items[]', function() {
                it.expects(json.keys['key_empty_array'].items.length).toEqual(0);
                it.expects(json.keys['key_array'].items[0].value).toEqual('array_1');
                it.expects(json.keys['key_nested_arrays'].items[1].items[0].items[0].value).toEqual(4);
            });

            it.should('retrieve object properties via keys[]', function() {
                it.expects(json.keys['key_empty_object'].keys.length).toEqual(0);
                it.expects(json.keys['key_object'].keys['object_1'].value).toEqual(1);
                it.expects(json.keys['key_nested_in_object'].keys['nested_2'].keys['c'].keys['z'].value).toEqual('Z');
            });
        }
    }
}
