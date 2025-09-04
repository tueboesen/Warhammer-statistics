import numpy as np
from tabulate import tabulate

def simulate_rolls(n_repeats, n_opponents, opponent_bonus):
    wins = 0
    for i in range(n_repeats):
        while True:
            rolls = np.random.randint(1, 101, size=(n_opponents + 1,))
            best_opponent_roll = np.max(rolls[1:]) + opponent_bonus
            if rolls[0] > best_opponent_roll:
                wins += 1
                break
            elif rolls[0] < best_opponent_roll:
                break
    return wins


n_repeats = 100000
n_opponents = [1,2,3,4,5,6,7,8,9,10]
opponent_bonus = [0,10]
win_percentage = np.empty((len(n_opponents), len(opponent_bonus)))

for i,n in enumerate(n_opponents):
    for j,b in enumerate(opponent_bonus):
        wins = simulate_rolls(n_repeats, n, b)
        win_percentage[i,j] = wins / n_repeats * 100

print(f"Win percentages based on {n_repeats} repeats")

tabulate_data = tabulate(win_percentage, headers=opponent_bonus, showindex=n_opponents)
print(tabulate_data)

