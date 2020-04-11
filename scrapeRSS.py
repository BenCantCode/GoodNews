import newspaper
import feedparser
from newspaper import Article
import csv
import pandas

rawrss = [
    'https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml', 
    'https://www.theguardian.com/world/rss', 
    'http://rss.cnn.com/rss/cnn_world.rss',
    'http://feeds.bbci.co.uk/news/world/rss.xml', 
    'https://abcnews.go.com/abcnews/topstories', 
    'https://www.cnbc.com/id/100727362/device/rss/rss.html',
    'https://feeds.a.dj.com/rss/RSSWorldNews.xml'
     ]

feeds = []

for url in rawrss:
    feeds.append(feedparser.parse(url))

posts = []
score = 0
for feed in feeds:
    for post in feed.entries:
        posts.append((post.title, post.link, score))

df = pandas.DataFrame(posts, columns=['title', 'link', 'score'])


postsX = []


for url in df['link']:
    
    x = Article(url)

    x.download()
    x.parse()
    postsX.append((x.title, x.text, score))
    #print(x.title + "\n")
    #print("\n")
    #print(x.text)

dfText = pandas.DataFrame(columns=['title', 'text', 'score'])
dfText.to_csv('fulltext', index = False)


