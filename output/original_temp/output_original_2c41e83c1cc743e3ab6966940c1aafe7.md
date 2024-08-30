**Evaluating Time Series Forecasts with GluonTS**

To calculate the Mean Squared Error (MSE), Standard Deviation (SD), and other useful metrics for evaluating time series forecasts, follow these steps:

### Step 1: Import Necessary Libraries

```python
import numpy as np
from gluonts.evaluation import Evaluator
from gluonts.evaluation.backtest import make_evaluation_predictions
```

### Step 2: Calculate Metrics

```python
# Calculate Mean Squared Error (MSE)
mse = np.mean([(f - t) ** 2 for f, t in zip(forecasts, timeseries)])

# Calculate Standard Deviation (SD)
sd = np.std([(f - t) ** 2 for f, t in zip(forecasts, timeseries)])

# Use GluonTS's built-in Evaluator for more metrics
evaluator = Evaluator(forecast_length=forecast_it.forecast_length)
forecast_items, ts_items = make_evaluation_predictions(
    dataset=test_ds, predictor=predictor, num_samples=100
)

eval_results, _ = evaluator(ts_items, forecast_items)

# Print the evaluation results
print("MSE:", mse)
print("SD:", sd)
print("MAE:", eval_results.mean_absolute_error)
print("RMSE:", np.sqrt(eval_results.mean_squared_error))
print("MAPE:", eval_results.mean_absolute_percentage_error)
```

### Explanation

- **Mean Squared Error (MSE)**: The average squared difference between forecast and actual values.
- **Standard Deviation (SD)**: The square root of the variance of the squared differences.
- **Mean Absolute Error (MAE)**: The average absolute difference between forecast and actual values.
- **Root Mean Squared Error (RMSE)**: The square root of the average squared difference between forecast and actual values.
- **Mean Absolute Percentage Error (MAPE)**: The average absolute percentage difference between forecast and actual values.

### Example Use Case

This code snippet is useful for evaluating the performance of a time series forecasting model. By calculating these metrics, you can assess the accuracy and reliability of your model's predictions.