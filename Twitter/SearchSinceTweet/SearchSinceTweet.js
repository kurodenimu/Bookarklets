

// URLからユーザネーム取得
const user = location.pathname.split("/")[1];

// URLからTweetID取得
const tweetid = location.pathname.split("/")[3];

// URL遷移
location.href = 'https://twitter.com/search?q=from%3A' + user + '%20since%3A' + getTweetDate(tweetid) + '&src=typed_query&f=live'

// TweetIDからTwitter検索用日付文字列取得
function getTweetDate(tweetid) {
    const twDate = new Date(parseInt(tweetid/(1<<22)+1288834974657));
    return twDate.getFullYear() + "-" + (twDate.getMonth() + 1).toString().padStart(2,"0") + "-" + twDate.getDate().toString().padStart(2,"0")
        + "_" + twDate.getHours().toString().padStart(2,"0") + ":" + twDate.getMinutes().toString().padStart(2,"0") + ":" + twDate.getSeconds().toString().padStart(2,"0")
        + "_JST";
}