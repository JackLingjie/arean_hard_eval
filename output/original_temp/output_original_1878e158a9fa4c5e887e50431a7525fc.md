**Sentiment Analysis Script**
================================

This Python script uses the Natural Language Processing (NLP) library, **NLTK**, and the **VaderSentiment** tool to perform sentiment analysis on text data.

### Requirements

- **NLTK** library: Install using `pip install nltk`
- **VaderSentiment** tool: Install using `pip install vaderSentiment`

### Code

```python
# Import necessary libraries
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

# Initialize the SentimentIntensityAnalyzer
sia = SentimentIntensityAnalyzer()

def analyze_sentiment(text):
    """
    Analyze the sentiment of the given text.

    Args:
        text (str): The text to analyze.

    Returns:
        dict: A dictionary containing the sentiment scores.
    """
    # Use the SentimentIntensityAnalyzer to get the sentiment scores
    sentiment_scores = sia.polarity_scores(text)

    return sentiment_scores

def classify_sentiment(sentiment_scores):
    """
    Classify the sentiment based on the scores.

    Args:
        sentiment_scores (dict): The sentiment scores.

    Returns:
        str: The classified sentiment.
    """
    # Determine the sentiment based on the compound score
    if sentiment_scores['compound'] >= 0.05:
        return "Positive"
    elif sentiment_scores['compound'] <= -0.05:
        return "Negative"
    else:
        return "Neutral"

# Example usage
text = "I love this product! It's amazing."
sentiment_scores = analyze_sentiment(text)
classified_sentiment = classify_sentiment(sentiment_scores)

print("Text:", text)
print("Sentiment Scores:", sentiment_scores)
print("Classified Sentiment:", classified_sentiment)
```

### Explanation

1. **Import Libraries**: The script starts by importing the necessary libraries: `nltk` and `vaderSentiment`.
2. **Initialize Analyzer**: It initializes the `SentimentIntensityAnalyzer` object, which is used to analyze the sentiment of text.
3. **Analyze Sentiment**: The `analyze_sentiment` function takes a text string as input and returns a dictionary containing the sentiment scores.
4. **Classify Sentiment**: The `classify_sentiment` function takes the sentiment scores as input and classifies the sentiment as positive, negative, or neutral based on the compound score.
5. **Example Usage**: The script demonstrates how to use the `analyze_sentiment` and `classify_sentiment` functions with an example text.

### Advice

- Make sure to download the required NLTK data using `nltk.download('vader_lexicon')`.
- You can adjust the threshold values in the `classify_sentiment` function to fine-tune the sentiment classification.
- This script uses a simple approach to sentiment analysis. For more accurate results, consider using more advanced techniques or libraries.