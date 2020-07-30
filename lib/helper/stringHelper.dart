class StringHelper {

  StringHelper();

  // use to find hash tag or http
  static List<String> keywordSearch(String value, String keyword) {
    List<String> rv = []; 
    List<String> words = value.split(" ");
    print(words);
    words.forEach((word) {
      if(word.startsWith(keyword) && word.length > 1) {
        String rest = word.substring(keyword.length);
        if(!rest.startsWith(" ") && !rv.contains(rest)) {
          rv.add(rest);
        }
      }
    });
    rv = rv.toSet().toList();
    return rv;
  }

  static String parseAddress(String messageDesc) {
        String rv;
        RegExp regExp = new RegExp(r'(地點|地址)(:| :|：| ：)(.*)', unicode: true);
        if(regExp.hasMatch(messageDesc)) {
          Match match = regExp.firstMatch(messageDesc); 
          if(match != null) {
            rv = match.group(3);
          }
        }
        return rv;
  }
}