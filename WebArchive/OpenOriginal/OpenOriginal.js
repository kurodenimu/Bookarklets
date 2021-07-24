const url = location.href.replace(RegExp("https://.*?(https?)"), "$1");
location.href = url;