To get the number of unresponsive pods in a Kubernetes cluster using PromQL (Prometheus Query Language), you can follow these steps:

1. **Identify the Relevant Metric**: 
   - The metric you're looking for is likely related to the liveness or readiness of pods. 
   - In Kubernetes, this information is often exposed through metrics like `kube_pod_status_running` or `kube_pod_status_unhealthy`.

2. **Understand the Metric Names**:
   - `kube_pod_status_running` indicates the number of running pods.
   - `kube_pod_status_unhealthy` indicates the number of unhealthy pods.

3. **Write Your PromQL Query**:
   - To find the number of unresponsive pods, you might need to query the `kube_pod_status_unhealthy` metric. However, this metric directly indicates unhealthy pods, which might not always be unresponsive.

   - A more direct approach to find unresponsive pods involves checking for pods that are not responding to health checks. This can be achieved by looking at the `kube_pod_status_condition` metric with the condition type being `Ready` or `NotReady`.

   - Here’s an example PromQL query to get the number of unresponsive pods:

     ```promql
     sum(kube_pod_status_condition{condition="Ready", status="False"})
     ```

     This query sums up the number of pods that are not ready.

4. **Run Your Query**:
   - Use a tool like `kubectl` with the `prometheus` plugin or a dedicated Prometheus UI to execute your query.

### Example Use Case

- **Query**: `sum(kube_pod_status_condition{condition="Ready", status="False"})`
- **Explanation**: This query counts the number of pods that are not ready. This can be a good indicator of unresponsive pods.

### Additional Tips

- **Metric Availability**: Ensure that the metrics you're trying to query are available in your Prometheus setup. This might involve configuring your Kubernetes cluster to expose these metrics.
- **Query Optimization**: Depending on your cluster size, you might need to optimize your query for performance. This could involve using `irate` or `rate` functions to reduce the amount of data being processed.

By following these steps, you can effectively use PromQL to find the number of unresponsive pods in your Kubernetes cluster.