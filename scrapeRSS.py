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

df.to_csv('container.csv', index=False)


f = open('container.csv')
csv_f = csv.reader(f)
for row in csv_f:
    print(row[1])


'''
url = 'post.link'

x = Article(url)

x.download()
x.parse()
print(x.title + "\n")
print("\n")
print(x.text)

'''