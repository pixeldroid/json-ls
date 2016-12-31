package
{
    import pixeldroid.bdd.Spec;
    import pixeldroid.bdd.Thing;

    import pixeldroid.json.Json;


    public static class JsonSpec
    {
        private static const it:Thing = Spec.describe('Json');

        public static function describe():void
        {
            it.should('be versioned', be_versioned);
            it.should('initialize from a valid JSON string', init_from_string);
            it.should('initialize from a native Loom object', init_from_object);
        }


        private static var json:Json;

        private static function describeValidInstance():void
        {
            it.should('report the native Loom type each value can be extracted as', report_native_types);
            it.should('retrieve native Loom types for the non-collection JSON types', get_native_types);
            it.should('retrieve array elements via items[]', get_array_elements_via_items);
            it.should('retrieve object properties via keys[]', get_object_props_via_keys);
        }


        private static function be_versioned():void
        {
            it.expects(Json.version).toPatternMatch('(%d+).(%d+).(%d+)', 3);
        }

        private static function init_from_string():void
        {
            var jsonFile:String = 'fixtures/json.json';
            var jsonString:String = File.loadTextFile(jsonFile);

            json = null;
            json = Json.fromString(jsonString);

            it.expects(json).not.toBeNull();
            describeValidInstance();
        }

        private static function init_from_object():void
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

            json = null;
            json = Json.fromObject(jsonObject);

            it.expects(json).not.toBeNull();
            describeValidInstance();
        }


        private static function report_native_types():void
        {
            if (json.keys['key_null']) it.expects(json.keys['key_null'].type).toEqual(Null.getType());
            it.expects(json.keys['key_bool_true'].type).toEqual(Boolean.getType());
            it.expects(json.keys['key_string'].type).toEqual(String.getType());
            it.expects(json.keys['key_number_integer'].type).toEqual(Number.getType());
            it.expects(json.keys['key_number_real'].type).toEqual(Number.getType());
            it.expects(json.keys['key_array'].type).toEqual(Vector.getType());
            it.expects(json.keys['key_object'].type).toEqual(Dictionary.getType());
        }

        private static function get_native_types():void
        {
            if (json.keys['key_null']) it.expects(json.keys['key_null'].value).toBeA(Null);

            it.expects(json.keys['key_bool_true'].value).toBeA(Boolean);
            it.expects(json.keys['key_bool_true'].value).toEqual(true);

            it.expects(json.keys['key_string'].value).toBeA(String);
            it.expects(json.keys['key_string'].value).toEqual('abcdefg ABCDEFG 0123_4567');

            it.expects(json.keys['key_number_integer'].value).toBeA(Number);
            it.expects(json.keys['key_number_integer'].value).toEqual(1234);

            it.expects(json.keys['key_number_real'].value).toBeA(Number);
            it.expects(json.keys['key_number_real'].value).toEqual(0.9876);
        }

        private static function get_array_elements_via_items():void
        {
            it.expects(json.keys['key_empty_array'].items.length).toEqual(0);
            it.expects(json.keys['key_array'].items[0].value).toEqual('array_1');
            it.expects(json.keys['key_nested_arrays'].items[1].items[0].items[0].value).toEqual(4);
        }

        private static function get_object_props_via_keys():void
        {
            it.expects(json.keys['key_empty_object'].keys.length).toEqual(0);
            it.expects(json.keys['key_object'].keys['object_1'].value).toEqual(1);
            it.expects(json.keys['key_nested_in_object'].keys['nested_2'].keys['c'].keys['z'].value).toEqual('Z');
        }
    }
}
