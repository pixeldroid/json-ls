package pixeldroid.json
{

    import system.JSON;
    import system.JSONType;

    public class Json
    {
        public static const version:String = '0.0.3';

        static public function fromString(value:String):Json
        {
            var j:JSON = new JSON();
            Debug.assert(j.loadString(value), "string was not able to be parsed as JSON");
            Debug.assert(j.getJSONType() == JSONType.JSON_OBJECT, "JSON root data type must be Object");

            return JSONObjectToJson(j);
        }

        static public function fromObject(value:Object):Json
        {
            return itemToJson(value);
        }

        public var keys:Dictionary.<String, Json> = {};
        public var items:Vector.<Json> = [];
        public var value:Object = null;
        public var type:Type = Null.getType();


        static private function itemToJson(item:Object):Json
        {
            if (item is Json) return item as Json;

            var json:Json = new Json();

            switch(item.getFullTypeName())
            {
                case 'system.Null' :
                    // this is the default value for a new Json
                break;

                case 'system.Boolean' :
                    json.type = Boolean.getType();
                    json.value = item;
                break;

                case 'system.Number' :
                    json.type = Number.getType();
                    json.value = item;
                break;

                case 'system.String' :
                    json.type = String.getType();
                    json.value = item;
                break;

                case 'system.Vector' :
                    json = VectorToJson(item as Vector.<Object>);
                break;

                case 'system.Dictionary' :
                    json = DictionaryToJson(item as Dictionary.<Object, Object>);
                break;

                default :
                    if (item.hasOwnProperty('toJson'))
                    {
                        var method:MethodInfo = item.getType().getMethodInfoByName('toJson');
                        if (method) json = method.invokeSingle(item, null) as Json;
                    }
                break;
            }

            return json;
        }

        static private function DictionaryToJson(d:Dictionary.<Object, Object>):Json
        {
            var json:Json = new Json();
            json.type = Dictionary.getType();
            json.value = json.keys;

            for (var key:Object in d)
            {
                json.keys[key.toString()] = itemToJson(d[key]);
            }

            return json;
        }

        static private function VectorToJson(v:Vector.<Object>):Json
        {
            var json:Json = new Json();
            json.type = Vector.getType();
            json.value = json.items;

            for (var index:Number in v)
            {
                json.items.push(itemToJson(v[index]));
            }

            return json;
        }


        static private function JSONItemToJson(key:Object, object:JSON, isArray:Boolean = false):Json
        {
            var json:Json = new Json();

            var item:JSON;
            var type:JSONType = isArray ? object.getArrayJSONType(key as Number) : object.getObjectJSONType(key as String);

            switch(type)
            {
                case JSONType.JSON_ARRAY:
                    item = isArray ? object.getArrayArray(key as Number) : object.getArray(key as String);
                    json = JSONArrayToJson(item);
                break;

                case JSONType.JSON_FALSE :
                    json.type = Boolean.getType();
                    json.value = false;
                break;

                case JSONType.JSON_INTEGER :
                    json.type = Number.getType();
                    json.value = isArray ? object.getArrayInteger(key as Number) : object.getInteger(key as String);
                break;

                case JSONType.JSON_NULL :
                    json.type = Null.getType();
                    json.value = null;
                break;

                case JSONType.JSON_OBJECT :
                    item = isArray ? object.getArrayObject(key as Number) : object.getObject(key as String);
                    json = JSONObjectToJson(item);
                break;

                case JSONType.JSON_REAL :
                    json.type = Number.getType();
                    json.value = isArray ? object.getArrayFloat(key as Number) : object.getFloat(key as String);
                break;

                case JSONType.JSON_STRING :
                    json.type = String.getType();
                    json.value = isArray ? object.getArrayString(key as Number) : object.getString(key as String);
                break;

                case JSONType.JSON_TRUE :
                    json.type = Boolean.getType();
                    json.value = true;
                break;

                default :
                    Debug.assert(false, "Unrecognized JSONType '" +type.toString() +"'");
                break;
            }

            return json;
        }

        static private function JSONObjectToJson(j:JSON):Json
        {
            var json:Json = new Json();
            json.type = Dictionary.getType();
            json.value = json.keys;

            var key:String = j.getObjectFirstKey();
            while(key)
            {
                json.keys[key] = JSONItemToJson(key, j);
                key = j.getObjectNextKey(key);
            }

            return json;
        }

        static private function JSONArrayToJson(j:JSON):Json
        {
            var json:Json = new Json();
            json.type = Vector.getType();
            json.value = json.items;

            var index:Number = 0;
            var count:Number = j.getArrayCount();
            while(index < count)
            {
                json.items.push(JSONItemToJson(index, j, true));
                index++;
            }

            return json;
        }
    }
}
