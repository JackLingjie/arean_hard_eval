To access the logs and see the R code running in real-time for the MetFamily Shiny app within the container, follow these steps:

### 1. **Accessing Container Logs**

- **Step 1**: Get the container ID:
  ```bash
  docker ps
  ```
- **Step 2**: Access the Docker container:
  ```bash
  docker exec -it <container_id> /bin/bash
  ```
- **Step 3**: Navigate to the `/tmp` directory:
  ```bash
  cd /tmp
  ```

### 2. **Running the Profiling Script**

- **Step 1**: Copy the `run_profvis.R` script into the container:
  ```bash
  docker cp E:\soft\MetFamily-master_14122023\MetFamily-master\run_profvis.R d47207e50eba:/tmp/
  ```
- **Step 2**: Run the profiling script:
  ```bash
  Rscript run_profvis.R
  ```

### 3. **Viewing Profiling Results**

- **Step 1**: After running the script, navigate to the directory where the profiling results are saved:
  ```bash
  cd /tmp
  ```
- **Step 2**: List the files in the directory to find the profiling results:
  ```bash
  ls
  ```
- **Step 3**: Open the profiling results file:
  ```bash
  profvis::profvisOutput("profiling_results.rds")
  ```

### 4. **Accessing Shiny App Logs**

- **Step 1**: To view the Shiny app logs in real-time, you can use the `R` console within the container:
  ```bash
  R
  ```
- **Step 2**: Load the Shiny app:
  ```r
  library(shiny)
  source("ui.R")
  source("server.R")
  ```
- **Step 3**: Run the Shiny app:
  ```r
  runApp()
  ```
- **Step 4**: The Shiny app will start, and you can view its logs in the `R` console.

### 5. **Combining Profiling and Logging**

- **Step 1**: Modify the `run_profvis.R` script to include logging:
  ```r
  library(shiny)
  library(profvis)
  library(lubridate)
  
  # Set the correct path to your Shiny app directory in the container
  setwd("/tmp/MetFamily/inst/MetFamily")
  
  # Define the Shiny application by sourcing both ui.R and server.R
  ui <- source("ui.R", local = TRUE)$value
  server <- source("server.R", local = TRUE)$value
  
  # Wrap the Shiny app initialization in profvis
  p <- profvis({
    # Log the start time
    log_time("Shiny App Started")
    
    # Run the Shiny app
    runApp(shinyApp(ui, server))
    
    # Log the end time
    log_time("Shiny App Ended")
  })
  
  # Save the profiling results
  saveRDS(p, file = "profiling_results.rds")
  
  # Function to log time
  log_time <- function(message) {
    cat(paste0(now(), " - ", message, "\n"))
  }
  
  # Instruct the script to wait before exiting
  # to give some time for the app to run and be profiled
  Sys.sleep(60)
  ```
- **Step 2**: Run the modified `run_profvis.R` script:
  ```bash
  Rscript run_profvis.R
  ```
- **Step 3**: View the logs in the `R` console.

By following these steps, you can access the logs and see the R code running in real-time for the MetFamily Shiny app within the container.