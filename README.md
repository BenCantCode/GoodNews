# Good News Everyone
<img src="https://media.giphy.com/media/3o7abA4a0QCXtSxGN2/giphy.gif">

Inspired by the optimistic attitude of Professor Farnsworth, our team sought out to make a high-quality news source that would only report *positive* news. The reasons for this are simple. 

People around the world are constantly subjected to an onslaught of negative news coverage, making people feel sad. According to leading psychologists, this type of coverage "can exacerbate or contribute to the development of stress, anxiety, depression and even post-traumatic stress disorder (PTSD)"<sup>1</sup> Furthermore, a 2018 study has shown that over half of all Americans report that news causes them stress.<sup>2</sup>

Despite this, traditional media platforms are incentivized to report negative news due to the amount of audience engagement, giving rise to the saying "if it bleeds, it leads". Other attempts at creating happy news are  manually curated, raising issues with potential biases of the creators for what might be called "uplifting".

Our solution utilizes the BERT model to perform sentiment analysis on the actual content of news articles (not only the headline). The news is refreshed every day using a variety of public RSS feeds and is displayed on a website (available at [https://goodnewseveryone.cc](https://goodnewseveryone.cc)) and on an app (with the source and Android build being available in the "app" folder of this repository). 

Our backend code is based on AWS' SageMaker and S3. The notebook we used for machine learning is in server/notebook.ipynb. We had tons of fun with this project and we hope that you see as much potential in it as we do.

1: [The Huffington Post](https://www.huffpost.com/entry/violent-media-anxiety_n_6671732) \
2: [American Psychological Association](https://www.apa.org/news/press/releases/2017/11/lowest-point)