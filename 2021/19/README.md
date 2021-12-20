# Introduction
What a day this AoC was. This was the first for me where I had no clue what was going on, and I struggled to grasp the basic concept. As the code challenges get more difficult, I have found myself transitioning from "solving and comparing" to "I'll learn something new today." This README for day 19 shows a few things I learned and the approach I ultimately took.

### Credit where credit is due
I got significant help on the overall concept from [this explanation](https://www.reddit.com/r/adventofcode/comments/rjpf7f/comment/hp5nnej/?utm_source=share&utm_medium=web2x&context=3) on Reddit ([the repo](https://github.com/mebeim/aoc/blob/master/2021/original_solutions/day19.py)). I ran into some is issues translating that Python to Ruby, and I ultimately used [this post](https://www.reddit.com/r/adventofcode/comments/rjpf7f/comment/hp844vn/?utm_source=share&utm_medium=web2x&context=3) and its [repo](https://gist.github.com/vincentwoo/dd1136e151c9035e090dd6401f301dcf) to get today's solution.

# Part 1
### Basic Concepts
"Wut." After researching how others approached this problem, I was thrown back to that Linear Algebra course I took in college and all of the horrors that an actual math course (not applied math for engineering) entailed. The basic idea of how a scanner works in today's problem is modeled by the concept of [basis vectors](https://en.wikipedia.org/wiki/Basis_(linear_algebra)). The concept of the potential rotation of a scanner is covered by the concept of [standard basis](https://en.wikipedia.org/wiki/Standard_basis). Ooof.

### Basic Approach
Given that each scanner had its own basis modeled by 24 potential standard bases, the solution to finding the # of beacons was something like the following (to my understanding.)
1. Read in scanner beacon data (stored as an array containing all beacons a scanner can read)
2. Transform each scanner's beacon data into all 24 potential bases (permutations, if you will)
3. Fingerprint each beacon for each scanner. I'll admit, this stage is where my understanding gets a little fuzzy, but I think this is where we're converting the 24 possible bases to a standard basis
4. Map each scanner beacon data against eachother. In this step, we're checking if a beacon from scanner a is the same beacon from scanner b. To do this, we calculate the distance vector between each beacon point. If at least 12 points match, we can conclude that this is the same beacon (per the problem statement.)
5. Evaluate for each possible scanner

The solution will then be a list of the distinct beacons

# Part 2
Based on the beacon data, we can also determine the scanner position. I'm a little fuzzy on how this works, but I understand the concept based on the problem statement. If we know the original scanner beacon data, and we know the distinct # of beacons and their locations, we can then back into where the actual scanner is located. 

Once we know our scanner location, we can apply the distance math the problem statement outlines.

# Lessons Learned
Did I learn or retain anything new about linear algebra? No (sorry, Dr. Caputo.) I did, however, learn some neat Ruby things:
- Vectors (we have some neat features from the `matrix` library including rotate, intersection, and transpose)
- Sets (no longer just manually making an array for me!)
- More neat stuff with maps
- A new way to read in files (this file split by line breaks instead of `readlines`. hmmm...)
