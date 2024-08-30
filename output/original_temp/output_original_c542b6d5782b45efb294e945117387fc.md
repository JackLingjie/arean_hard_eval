**DVD Screen Saver Logo Bouncer**

This script creates a bouncing DVD logo that increments a score each time it touches a screen corner.

### Requirements

- Python 3.x
- Pygame library (`pip install pygame`)

### Code

```python
import pygame
import sys

# Initialize Pygame
pygame.init()

# Screen dimensions
SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600

# Set up display
screen = pygame.display.set_mode((SCREEN_WIDTH, SCREEN_HEIGHT))

# DVD logo image
DVD_LOGO = pygame.Surface((50, 50))
DVD_LOGO.fill((255, 0, 0))  # Red color

# Initial logo position
logo_x = SCREEN_WIDTH // 2
logo_y = SCREEN_HEIGHT // 2

# Initial velocity
velocity_x = 3
velocity_y = 3

# Score
score = 0

# Game loop
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    # Fill screen with black
    screen.fill((0, 0, 0))

    # Draw DVD logo
    screen.blit(DVD_LOGO, (logo_x, logo_y))

    # Update logo position
    logo_x += velocity_x
    logo_y += velocity_y

    # Bounce off edges
    if logo_x < 0 or logo_x > SCREEN_WIDTH - DVD_LOGO.get_width():
        velocity_x *= -1
        score += 1
    if logo_y < 0 or logo_y > SCREEN_HEIGHT - DVD_LOGO.get_height():
        velocity_y *= -1
        score += 1

    # Display score
    font = pygame.font.Font(None, 36)
    text = font.render(f"Score: {score}", True, (255, 255, 255))
    screen.blit(text, (10, 10))

    # Update display
    pygame.display.flip()

    # Cap framerate
    pygame.time.Clock().tick(60)
```

### Explanation

- This script initializes Pygame and sets up a window with a black background.
- It loads a red square as the DVD logo.
- The logo starts at the center of the screen with a velocity.
- The game loop continuously updates the logo's position, checks for collisions with the screen edges, and increments the score when a corner is touched.
- The score is displayed at the top-left corner of the screen.

### Running the Script

1. Install the required `pygame` library using pip: `pip install pygame`
2. Save this script as `dvd_screensaver.py`
3. Run the script using Python: `python dvd_screensaver.py`

This will launch the DVD screen saver logo bouncer.