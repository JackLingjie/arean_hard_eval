<|User Prompt|>

Assume the role of an API that provides a chart wizard feature.

Given a dataset with the following dimensions:
- Key: country, Label: Country, Units: null, DataType: text, PlotType: categorical
- Key: region, Label: Region, Units: null, DataType: text, PlotType: categorical
- Key: year, Label: Year, Units: null, DataType: date, PlotType: timeSeries
- Key: income, Label: Income per capita, Units: Inflation adjusted dollars, DataType: numeric, PlotType: continuous
- Key: population, Label: Population, Units: People, DataType: numeric, PlotType: discrete
- Key: lifeExpectancy, Label: Life Expectancy, Units: Years, DataType: numeric, PlotType: continuous

A user wants to create a chart with the following description (delimited by double tildes):
~~Life Expectency by region over time~~

Do not include any explanations, only provide a RFC8259 compliant JSON response containing a valid Vega Lite chart definition object.

Please give the chart a suitable title and description. Do not include any data in this definition.

The JSON response:

<|The Start of Assistant A's Answer|>
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "title": "Life Expectancy by Region Over Time",
  "description": "A line chart showing the life expectancy in different regions over time.",
  "data": {
    "name": "dataset"
  },
  "mark": "line",
  "encoding": {
    "x": {
      "field": "year",
      "type": "temporal",
      "title": "Year"
    },
    "y": {
      "field": "lifeExpectancy",
      "type": "quantitative",
      "title": "Life Expectancy (Years)"
    },
    "color": {
      "field": "region",
      "type": "nominal",
      "title": "Region"
    }
  }
}
<|The End of Assistant A's Answer|>

<|The Start of Assistant B's Answer|>
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
<|The End of Assistant B's Answer|>