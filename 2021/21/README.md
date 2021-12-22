# Introduction
Today was super easy at first, and then it went downhill fast. I learned a lot through each dice technique, and I'll describe my thought process for each part below.

# Part 1
I really enjoyed this part, as it allowed me to practice more OOP with Ruby. For deterministic games, I figured that there were 3 primary objects of consideration
1. A game (with 2 players and 1 die)
2. A player (with a current position, current score, and player id)
3. A die (with a # of sides, current value, and # of times it has been rolled)

At least for Part 1, I felt that tracking a game containing players and a die was out of the scope. I had a feeling that we would have to do _something_ with a game for Part 2 (more than 1 player, different die, more than one game board, etc.) so I structured my Player and Die classes accordingly.

A player would know how to move and update its score my rolling a die, and a die would know its logic for rolling (deterministic, random, etc.) and which value to return based on its own logic.

From there, we simply looped taking turns until a win occured.

# Part 2
As I had to type die over and over again, "die" started to feel more like my actual feelings towards Part 2. I want to give credit to [this Reddit comment](https://www.reddit.com/r/adventofcode/comments/rl6p8y/comment/hph4r3k/?utm_source=share&utm_medium=web2x&context=3) for explaining the general concept, and [this Reddit comment](https://www.reddit.com/r/adventofcode/comments/rl6p8y/2021_day_21_solutions/hphgf1u/?utm_source=share&utm_medium=web2x&context=3) and its [corresponding repo](https://github.com/HrRodan/adventofcode2021/blob/master/day21/day21_part2.py) for ultimately bringing me to a solution that I could translate from Python to Ruby. I sure do appreciate how popular Python is and that it was the first programming language I learned (aside from Excel VBA and C++ from Programming 1.)

Because of the distinct logic of a dirac die, I created a new DiracDie class and updated the Player class to have a method for each different type of die roll.

### Initial Approach
Before I get to my understanding of the solution, I want to talk about my inital approach. Thinking back to Part 1, I realized that my idea of a "board" class more or less represented the different universes resulting from our dirac die. Given the various challenges so far in AoC this year and the sample universe count being `444356092776315`, I realized that this would very easily become an exponential memory monster if I were to track each permutation. Perusing the Reddit comments for hints, I also learned that many of these different branching universes could overlap. Although I knew a literal approach would not result in a memory feasible solution, I wanted to explore a little bit to better understand the dirac die logic. This can be seen in the logic from [this commit](https://github.com/evanwestbrook/advent_of_code/commit/5655fc92d6fa024a1aa9e523fa2028064812e38d#diff-446fc3f17f994f5a15f80e03213b9ef83bfd3bfb34df72fed55d097db0357416).

While it did result as expected (slowing down very quickly!), I did learn the basic logic.

### The next failed approach
I had a lot of success using the "frequency of state" concept for the Laternfish challenge. I figured that in this situation, given the # of spaces on the board, we could just track the # of permutation with dice combos and track wins from there. Each possible permutation would still be a big list, but it would be better than the exponential problem from my inital approach. Here's [the commmit](https://github.com/evanwestbrook/advent_of_code/commit/58391aa3f7532ab4f1d6a336b9ba7a54eb39d510#diff-446fc3f17f994f5a15f80e03213b9ef83bfd3bfb34df72fed55d097db0357416) where that logic was introduced. 

It turns out that I was on the right track, but I was thinking about it wrong. The logic on this approach was creating a hash of all possible board location and die results. For example, `{ space_n: die_val_1, space_n: die_val_1, space_n: die_val_1, space_n+1: die_val_1, ... }` --> `{ 4: 1, 4: 2, 4: 3, 5: 1, ... }`.

After scratching my head at seemingly infinite loops and doing some work on scratch paper, I realized that this would not work because, while I was caputuring the count in each state, I was not tracking the current score. I had incorrectly assumed that any board space state would have the same score. That was not correct. We could have different scores in different universes for the same board space. Here's an example of that scratch work and a nice example of how the logic for 1 dirac roll works:

For each universe, I am representing position and score as `{pos: val}`. I try to resprsent each universe split with a `[]`, `-`, or `|`. Each roll results in `Roll 1: --> 1, 2, 3`

Initial position: 4

Roll 1 Universes --> `[{5: 5}, {6: 6}, {7: 7}]`

Roll 2 Universes --> `[{6: 11}, {7: 12}, {8: 13}] - [{7: 13}, {8: 14}, {9: 15}] - [{8: 15}, {9: 16}, {10: 17}]`

Roll 3 Universes --> `[{7: 18}, {8: 19}, {9: 20}] | [{8: 20}, {9: 21}, {10: 22}] | [{9: 22}, {10: 23}, {1: 14}] - [{8: 21}, {9: 22}, {10: 23}] | [{9: 23}, {10: 24}, {1: 16}] | [{10: 25}, {1: 16}, {2: 17}] - [{9: 24}, {10: 25}, {1: 16}] | [{10: 26}, {1: 17}, {2: 18}] | [{1: 18}, {2: 19}, {3: 20}]`

This logic gave my frequency hash something like the following for `{pos: # in pos}`:

`current positions: {1: 6, 2: 3, 3: 1, 7: 1, 8: 1, 9: 1} wins for player on this turn: 13`

We now have the # of wins a player had in a turn and the counts of where the player is on the board in each of our universes. In other words, for this turn, instead of storing 27 (roll 3 universes length) different universes, we're only storing 6 (current positions length)! Great? Not so much. When doing this scratch work, I realized that even though board positions overlap betwen universes, the scores don't. Take position 2 for example. After Roll 3, position 2 has scores of 17, 18, and 19. I somehow needed to track the score for each of these universes. This meant that intead of scoring 6 universes, I would still need to store 14 (27 - 13 wins,) and that was just one step for one player! I couldn't quite figure out how to update this logic to also store scores in a non-memory instensive way, so I went searching for more answers.

### The winning approach

