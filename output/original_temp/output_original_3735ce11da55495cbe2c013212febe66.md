**Elo Score Calculator for a Chess Tournament**

This program calculates the Elo scores of players in a chess tournament. The Elo system is a method for calculating the relative skill levels of players in a competitive environment.

### **Elo Score Formula**

The Elo score formula is:

\[ S_{new} = S_{old} + K \times (R - E_{old} ) \]

where:
- \( S_{new} \) is the new Elo score.
- \( S_{old} \) is the old Elo score.
- \( K \) is the K-factor (a constant that determines how much the rating changes after each game).
- \( R \) is the result of the game (1 for a win, 0.5 for a draw, and 0 for a loss).
- \( E_{old} \) is the expected score.

### **Implementation**

```python
class Player:
    """Represents a player in the chess tournament."""
    
    def __init__(self, name, elo_score):
        """
        Initializes a Player instance.

        Args:
            name (str): The player's name.
            elo_score (float): The player's initial Elo score.
        """
        self.name = name
        self.elo_score = elo_score

    def update_elo(self, result, opponent_elo, k_factor):
        """
        Updates the player's Elo score after a game.

        Args:
            result (float): The result of the game (1 for a win, 0.5 for a draw, and 0 for a loss).
            opponent_elo (float): The opponent's Elo score.
            k_factor (float): The K-factor.
        """
        # Calculate the expected score
        expected_score = 1 / (1 + 10 ** ((opponent_elo - self.elo_score) / 400))
        
        # Update the Elo score
        self.elo_score += k_factor * (result - expected_score)


def calculate_tournament_results(players, results, k_factor):
    """
    Calculates the Elo scores of players in a chess tournament.

    Args:
        players (list[Player]): A list of Player instances.
        results (list[tuple]): A list of tuples containing the result of each game.
            Each tuple contains the winner's index, the loser's index, and the result (1 for a win, 0.5 for a draw, and 0 for a loss).
        k_factor (float): The K-factor.

    Returns:
        list[Player]: The updated list of Player instances.
    """
    for i, (winner_index, loser_index, result) in enumerate(results):
        # Get the players involved in the game
        winner = players[winner_index]
        loser = players[loser_index]
        
        # Update the Elo scores
        winner.update_elo(result, loser.elo_score, k_factor)
        loser.update_elo(1 - result, winner.elo_score, k_factor)

    return players


# Example usage
if __name__ == "__main__":
    # Initialize players
    players = [
        Player("Player 1", 1500),
        Player("Player 2", 1200),
        Player("Player 3", 1800),
    ]

    # Define the results of the games
    results = [
        (0, 1, 1),  # Player 1 wins against Player 2
        (1, 2, 0.5),  # Player 2 draws against Player 3
        (2, 0, 1),  # Player 3 wins against Player 1
    ]

    # Calculate the Elo scores
    k_factor = 32  # The K-factor for a standard tournament
    updated_players = calculate_tournament_results(players, results, k_factor)

    # Print the updated Elo scores
    for player in updated_players:
        print(f"{player.name}: {player.elo_score}")
```

### **Explanation**

This program defines a `Player` class to represent players in the chess tournament. Each player has a name and an initial Elo score.

The `calculate_tournament_results` function takes a list of players, a list of game results, and the K-factor as input. It updates the Elo scores of the players based on the game results.

In the example usage, we initialize three players with different Elo scores. We then define the results of three games. Finally, we calculate the updated Elo scores using the `calculate_tournament_results` function and print the results.

### **Advice**

- Use a suitable K-factor for your tournament. A higher K-factor means more significant rating changes after each game.
- Ensure that the game results are accurate and consistent.
- You can modify the `Player` class to include additional attributes or methods as needed.
- This program assumes a standard Elo rating system. If you need to implement a modified version, adjust the formula and calculations accordingly.