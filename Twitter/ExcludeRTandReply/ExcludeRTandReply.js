if (location.hostname == 'twitter.com') {
    var user = location.pathname.replace('/', '');
    location.href = 'https://twitter.com/search?q=from%3A' + user + '%20exclude%3Areplies&src=typed_query&f=live'
}