You can use the following MATLAB code to pause the script until all figures are closed:

```matlab
% Pause the script until all figures are closed
while get(0, 'Visible') 
    % Do nothing, wait for user to close all figures
end
```

Here's how it works:

- `get(0, 'Visible')` checks if any figures are still visible.
- The `while` loop continues to execute as long as there are visible figures.
- Once all figures are closed, the loop exits, and the script continues.

This approach allows the user to close figures in any order before the script proceeds. 

**Example Use Case:**

```matlab
% Create some figures
figure;
figure;
figure;

% Pause the script until all figures are closed
while get(0, 'Visible') 
    % Do nothing, wait for user to close all figures
end

% Script continues here
disp("All figures closed. Continuing...");
```