To code the snake game in C that will be smooth and use images to animate the whole level, you can follow these steps:

1. Create a game board: Define a 2D array to represent the game board. Each element in the array can be either a wall, a food, or empty space.

2. Initialize the snake: Create a list of coordinates that represent the snake's body. The head of the snake should be at the center of the board, and the tail should be at the edge of the board.

3. Draw the game board: Use graphics libraries like SDL or OpenGL to draw the game board and the snake's body. You can use images to represent the walls, food, and snake segments.

4. Move the snake: Use a loop to iterate through the snake's body and move each segment one step in the direction of the snake's head. If the snake's head hits a wall or itself, end the game.

5. Check for food: If the snake's head is on top of a food item, add a new segment to the snake's body and generate a new food item at a random location.

6. Update the game state: Use a timer to update the game state at a consistent rate. This will ensure that the game runs smoothly and the snake moves at a consistent speed.

7. Handle user input: Use keyboard or mouse input to control the snake's direction. For example, pressing the left arrow key could make the snake turn left.

8. Display the game state: Use graphics libraries to display the game state, including the game board, snake's body, and food items.

9. Repeat: Repeat steps 4-8 until the game is over.

By following these steps, you can create a smooth and visually appealing snake game in C that uses images to animate the whole level.