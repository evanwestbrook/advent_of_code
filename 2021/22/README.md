# Introduction
Today's problem was a little easier to grasp for me. As per usual these days, I could understand the first portion, and I needed help on the second portion. 

# Part 1
Part 1 could be summarized as "evaluate each step within a 50x50x50 cube." I was able to get a correct solution with my initial structure using the following steps:

1. Store the state of each location in the cube in a hash with the structure { xcoord_ycoord_z_coord: state }
2. Make sure all directions of a command were within the cubes's range. If at least 1 was outside of the range, we wouldn't be evaluating the step
3. If the command's range was outside of the cube's range, but the cube feel into the range, truncate the command range down to 50x50x50.
4. For each location (x, y, z) in the command range, update the locations's state
5. Count the # of locations where state = "on"

I gradually leaned down my Part 1 solution a few times. Here are some notes on that for each iteration
1. I started with initializing a full 50x50x50 cube with all states being "off". That took a while to compute on startup, and I realized that I didn't need to pre-compute the starting state of the cube. Since each location starts as "off" we're only evaluating something if it was turned "on" at least once. Because of this, I would just add a location to the reactor hash if it was turned on
2. We have to process every "on" action, but we don't need to process an "off" action if a location has never been turned on. Instead of adding all "off" actions to our reactor hash and unecessarily making it larger, we just need to check if something in the "off" command range is on instead of off.

# Part 2
### Initial Attempt
I thought I could run my Part 1 solution with a slight update to the step process (no need to truncate the command range anymore.) Pretty soon, I started seeing huge runtimes starting at Step 21. I through maybe I could brute force the problem, so I ran the model and got lunch. When I came back around 30 minutes later, the program was _still_ on Step 21. Looking into the actual test data, I realized that this was because the x range was having to evaluate 32,764 times! And the later steps looked even worse. I realized that a literal interpretation of the prompt wasn't going to work here.

### Solution 
After thinking about it a bit, I realized that we don't actually need to track the state of each location in the reactor cube. The input's format actualy provides a hint here. Instead of tracking the state of _each_ location, we just need to track _sections_ of the reactor that are turned on at a given time. For each command, we could end up expanding, shrinking, or splitting those ranges.

I tried some implementations myself, but I couldn't quite get it. To save some time and learn today, I referenced [this Python solution](https://github.com/purple4reina/advent-of-code-2021/blob/main/day22/day.py) done my another employee for the company where I work. It implemented something close to the "sections storage" concept outlined above. For each command, it does the following:

1. Tracks the # of spaces turned on if this was an "on" step based on the ranges command
2. Adds this range to the next list of previous steps to be evaluated after this step
3. For each previous step
    - Add it to the next list of previous steps to be evaluated after this step
    - Determine if any additional step ranges have been turned on
    - If so, increase the # of spaces turned on or reduce it if turned off
5. Repeat for all steps

When I say this is similar to my idea, what I mean is that it's not relying on keeping track of the current state of the reactor and then doing the total math after the fact. That would be tricky. We could very easily have cases where an "on" cube has a smaller "off" cube within it or overlapping it. Instead of a cube, that would give us a more complex polygon. Eeek. Who would want to evaluate that?

This solution avoids the polygon problem by evaluating a point's history. To my understanding, it is doing the following for each step
1. Evaluate this step (on or off)
2. Compare this step with all previous steps

Here's an example that may explain the concept for `location_a` and `location_b`. Let's say we have the following list of step actions
1. on location_a
2. on location_b
3. off location_a location_b
4. on location_a

Let's represent the state of these two points as `[location_a, location_b]` and "on" as 1 and "off" as 0

`Starting state: [0, 0]`
1. State: [1, 0]
    - Previous total action: nil
    - This action: +1
    - Total on: 1 = nil + 1
2. State: [1, 1]
    - Previous total action: +1
    - This action: + 1
    - Total on: 2 = 1 + 1
3. State: [0, 0]
    - Previous total action: +1, +1
    - This action: -2
    - Total on: 0 = 1 + 1 - 2
4. State: [1, 0]
    - Previous total action: +1, +1, -2
    - This action: +1
    - Total on: 1 = 1 + 1 - 2 + 1

After Step 4, we would have 1 out of 2 locations on. The "-1" value seen in the code implementation is introduced to balance out previous "on" actions if one occured during a turn.
