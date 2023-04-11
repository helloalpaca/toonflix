typedef DictionaryType = Map<String, String>;

class Dictionary {
  DictionaryType arr = {};

  Dictionary(this.arr);

  void add(String key, String value) {
    arr[key] = value;
  }

  String get(String key) {
    for (var entry in arr.entries) {
      if (entry.key == key) {
        return entry.value;
      }
    }
    return "NO MATCH VALUES";
  }

  void delete(String key) {
    arr.remove(key);
  }

  void update(String key, String value) {
    for (var entry in arr.entries) {
      if (entry.key == key) {
        arr[key] = value;
      }
    }
  }

  void showAll() {
    print(arr.keys);
  }

  int count() {
    return arr.length;
  }

  void upsert(String key, String value) {
    arr[key] = value;
  }

  bool exists(String key) {
    for (var entry in arr.entries) {
      if (entry.key == key) {
        return true;
      }
    }
    return false;
  }

  void bulkAdd(List<DictionaryType> data) {
    for (var element in data) {
      var term = element["term"];
      var definition = element["definition"];
      if (term != null && definition != null) {
        arr[term] = definition;
      }
    }
  }

  void bulkDelete(List<String> keys) {
    for (var key in keys) {
      arr.remove(key);
    }
  }
}

/*
void main() {
  
  var dict = Dictionary({"HELLO": "DEFINITION"});
  dict.add("BYE", "BYE_DEF");
  dict.showAll();
  print(dict.get("HELLO"));
  dict.update("MEMEMEME", "GOODBYE");
  dict.showAll();
  dict.delete("HELLO");
  dict.showAll();
  dict.upsert("MEMEMEME", "GOODBYE");
  dict.showAll();
  dict.bulkAdd([{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]);
  dict.showAll();
  dict.bulkDelete(["BYE", "김치"]);
  dict.showAll();
}
*/