# Introduction
This way my first code challenge for AoC ever. I started the challenges about 1 week late, so I was fortunate enough to be able to look at some examples to learn basic things like reading a file in. I was also able to set my goals for this challenge:
1. To use Ruby and learn more about it compared with my existing knowledge of JavaScript
2. To learn new features from others

# Part 1
This problem was relateively straight forward. I approached it by processing the sonar readings and adding them to an array. After each item was added into the array, we reference the relevant values and potentially increment a counter of the # of increases.

# Part 2
This just invovled adding a little more logic into our sonar reading logic. Instead of finding the raw # of times the sonar reading increased, we just had to consider 3 periods at a time. This was accomplished by introducing `make_sum`

# Lessons Learned
Being the first challenge, I learned a few useful things about Ruby
1. How to read files in `File.readlines(filepath)`
2. How to do a `for` loop in Ruby. I do realize that ruby has its own `for` loop logic, but the `each` and `each_with_index` loop methods are much more convenient. For one, the code is easier to read. I am also encountering fewer issues of "juggling" iterators like I would have to do in JavaScript
3. Different ways to print results and debugging statements. For example, `puts` will print everything in an array on a separate line. To more properly test, I must use `p` or `puts "{#array}"`

# Refactoring
After completing this one, I refactored it based on some lessons I had learned about Ruby native enumerables. Key takeaways from the refactor include: 
1. For parsing an input file into an array, collect does a lot of work for us. Map does the same thing. Collect is used an an alias for Map because map can do different things depending on language. For example, in JavaScript, it roughly does the equivalent of a `for each`. In Ruby it does closer to a `for each and store in array`
2. Each consecutive (`each_cons`) works well for comparing items in an array similar to how a .each_with_index would work. However, it is a little easier to read, as there are fewer instances where we are juggling indices
3. Inject was not as useful here as a solution because we are not doing something cumulative. The solution relies on items from previous aspects of the array
4. There are some shortcuts to summing everything like using `&:sum`. I'm still not 100% on how that works.
