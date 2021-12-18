# Part 1
### Initial approach
When I initially approached this solution, I thought using `eval()` to parse each string into an array and then apply additional logic was a no brainer. After successfully applying basic `add` and `split` functionality, I started to get stumped on `explode`. I knew it would be some sort of recursive analysis, and I was getting stumped at the concept of determining which element of an array and at which depth to explode. I had also fallen intro the trap on previous AoC challenges with spending way too much time chasing a recursive problem. I also started to think that actual string parsing might be better off. In other words, maybe the solution lay closer to counting the # of array like characters than actually traversing a nested array repeatedly.

### Determining a solution approach
With my stuck initial approach in mind, I went looking for hints on the [AoC Reddit](https://www.reddit.com/r/adventofcode/comments/rizw2c/2021_day_18_solutions/). Both Ruby solutions ([1](https://www.reddit.com/r/adventofcode/comments/rizw2c/comment/hp0w9e4/?utm_source=share&utm_medium=web2x&context=3) and [2](https://www.reddit.com/r/adventofcode/comments/rizw2c/comment/hp18eju/?utm_source=share&utm_medium=web2x&context=3
)) that were posted at my time of checking involved tracking the depth of a given number. I realized that "depth" was the concept I was trying to describe with "counting the # of array like characters." Instead of trying to traverse the array and keep track of that format, we would instead track number and the depth. Since most key logic of this challenge involved depth, this would allow us to solve the solution while keeping it in a data format more suited to the end solution

### Getting to the solution
Knowing to use a depth based approach was helpful, but I was still a little lost. Because of that, I decided to use today as a "learning" day and work along with the second posted solution since it had much more explanation. My commit history and comments will show the basic logic, so I wanted to highlight a few things that I learned along the way

1. The solution makes heavy used of the [Ruby Complex number class](https://ruby-doc.org/core-2.5.0/Complex.html). In this logic, instead of traversing arrays, we use a complex number to encode the number and its depth. I did not know about this class, and it make for a convenient group of methods to handle the `regular number` and `depth` aspects with an off the shelf function.
2. This solution also made heavy use of [numbered parameters](https://medium.com/@baweaver/ruby-2-7-numbered-parameters-3f5c06a55fe4). This was a concept that I was also not familiar with. Numbered parameters seem like a nice easier method for keeping track of items with indices, especially when using `map`.
 
# Part 2
Given the logic determined in Part 1, Part 2 was relatively straightforward. I learned a few things here worth mentioning:
1. [Permutation](https://www.geeksforgeeks.org/ruby-array-permutation-function/) takes an array and gives all possible combinations. It was another great off the shelf means to determine all possible combinations and combine them in an array format that was useful for the problem. Once the permuation was complete, we just needed to get the magnitude of our add methods and return the max
