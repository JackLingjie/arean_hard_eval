**Traffic Flow Modeling with the Greenshields Model**

### Problem Statement

Estimate the travel time from home to work using the Greenshields model under two scenarios:

1. **No Rainfall**: Calculate the travel time when there is no rainfall.
2. **Rainfall**: Calculate the travel time when it is raining.

### Greenshields Model Formulation

The Greenshields model is a fundamental traffic flow model. It relates the speed of vehicles to the density of traffic. The model is formulated as:

\[ v = v_f \left( 1 - \frac{\rho}{\rho_m} \right) \]

where:
- \( v \) is the speed of vehicles,
- \( v_f \) is the free-flow speed,
- \( \rho \) is the traffic density, and
- \( \rho_m \) is the maximum traffic density.

### Python Implementation

```python
def greenshields_model(v_f, rho, rho_m):
    """
    Calculate the speed of vehicles using the Greenshields model.

    Args:
    - v_f (float): Free-flow speed.
    - rho (float): Traffic density.
    - rho_m (float): Maximum traffic density.

    Returns:
    - float: Speed of vehicles.
    """
    return v_f * (1 - rho / rho_m)


def calculate_travel_time(distance, speed):
    """
    Calculate the travel time.

    Args:
    - distance (float): Distance between home and work.
    - speed (float): Speed of vehicles.

    Returns:
    - float: Travel time.
    """
    return distance / speed


# Define parameters
free_flow_speed = 40  # km/h
max_density = 150     # vehicles/km
traffic_density_no_rain = 50  # vehicles/km
traffic_density_rain = 70    # vehicles/km
distance_home_work = 20      # km

# Scenario 1: No Rainfall
speed_no_rain = greenshields_model(free_flow_speed, traffic_density_no_rain, max_density)
travel_time_no_rain = calculate_travel_time(distance_home_work, speed_no_rain)

# Scenario 2: Rainfall
speed_rain = greenshields_model(free_flow_speed, traffic_density_rain, max_density)
travel_time_rain = calculate_travel_time(distance_home_work, speed_rain)

# Print results
print("Travel Time Without Rainfall:", travel_time_no_rain, "hours")
print("Travel Time With Rainfall:", travel_time_rain, "hours")
```

### Explanation

1. **Greenshields Model Function**: The `greenshields_model` function calculates the speed of vehicles using the Greenshields model.
2. **Travel Time Calculation**: The `calculate_travel_time` function calculates the travel time based on the distance and speed.
3. **Scenario Parameters**: Define parameters for both scenarios: no rainfall and rainfall.
4. **Calculate Speeds and Travel Times**: Use the defined functions to calculate the speeds and travel times for both scenarios.
5. **Print Results**: Print the travel times for both scenarios.

### Example Use Cases

- **Traffic Management**: Use this model to estimate travel times and manage traffic flow during peak hours or in areas prone to rainfall.
- **Transportation Planning**: Apply the Greenshields model to plan efficient transportation systems, considering factors like traffic density and rainfall.

### Advice

- **Real-World Applications**: Consider real-world factors like road conditions, traffic signals, and pedestrian crossings when applying the Greenshields model.
- **Model Extensions**: Explore extensions to the Greenshields model, such as incorporating more variables or using machine learning techniques.