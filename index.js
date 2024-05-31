function splitURLandReturnComponents(url) {
    var urlComponents = {};
    var urlParts = url.split('?');
    urlComponents['url'] = urlParts[0];
    if (urlParts.length > 1) {
        var queryString = urlParts[1];
        var queryParts = queryString.split('&');
        for (var i = 0; i < queryParts.length; i++) {
            var keyValuePair = queryParts[i].split('=');
            urlComponents[keyValuePair[0]] = keyValuePair[1];
        }
    }
    return urlComponents;
}