```json
{
  "mark": "line",
  "encoding": {
    "x": {
      "field": "year",
      "type": "temporal"
    },
    "y": {
      "field": "lifeExpectancy",
      "type": "quantitative"
    },
    "color": {
      "field": "region",
      "type": "nominal"
    }
  },
  "transform": [
    {
      "fold": "array",
      "as": [
        {"column": "region"},
        {"column": "lifeExpectancy"}
      ],
      "key": "region"
    }
  ],
  "config": {
    "axisY": {
      "title": "Life Expectancy"
    },
    "axisX": {
      "title": "Year"
    },
    "title": "Life Expectancy by Region over Time"
  }
}
```