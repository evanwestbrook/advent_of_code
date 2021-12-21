# Introduction
Today's challenge was all about finding frequencies of values at specific indices (bit) for a list of strings (bytes) and performing further logic on them. Overall, the logic to be performed for a list of "bytes" (in this case just strings):
1. Find the most common value for each index ("bit")
2. Determine if it is a 0 or 1 based on the reading type
3. Combine the result from Step 2 into a string representing a binary number
4. Convert the result of Step 3 into a decimal
5. Quick maths

# Approach
Today's Part 1 and Part 2 challenges built on eachother enough that I won't split up the approaches today. Instead, I'll talk about how I approached each step above

### Step 1: Find the most common value for each index
`get_bit_frequency` and `update_bit_frequency` do the heavy lifting here. It iterates over each byte, and adds the bits to a hash of the frequencies. The logic here may be a bit hidden. Essentially, since the bits are always 0 or 1, adding up the bits will show us the # of times 1 appears for a given index. The result gives us a hash of the # of times 1 occured at each index without any evaluations (yay). For example:
`{0=>7, 1=>5, 2=>8, 3=>7, 4=>5}`

### Step 2 Determine if it is a 0 or 2 based on the reading type
From here, `get_binary_readings` and `get_bit_value` do the heavy lifting: 
1. We use our `frequency_list` from Step 1 to iterate over each index
2. We use `num_readings` to calculate whether 1 or 0 is the most common value for a given index
3. We use `bit_criteria` to apply rules for `Gamma` and `Epsilon` rates in `get_bit_value`

### Step 3 Combine the result from Step 2 into a string representing a binary number
`get_binary_readings` involves combining all of the `get_bit_value` results into a binary number.

### Step 4 Convert the result of Step 3 into a decimal
To allow for better print readouts, we do all of our decimal conversion when displaying our results. We can also use Ruby's handy binary to decimal converter `.to_i(2)`.

### Step 5 Quick Maths
From here, we can just apply the math that the prompt gives us.

### Part 2 Differences
Part 2 wants us to consider just the most common first bit. We can easily reuse `get_bit_frequency` and `get_bit_value` here. From there, we just create our binary number from the remaining bytes using `truncate_vals_list`

# Future Improvements
While I learned a lot about hashes and lists and binary conversions, there's always room for improvement. All of these methods seem rather hard coded. Each total reading seems close to an inverse of the other (`gamma` vs `episilon`, `oxygen` vs `c02`, etc.). Would it be possible to only perform one iteration for each end result (power, life support, etc.) instead of the current 4 for each value.
