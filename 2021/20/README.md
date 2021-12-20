# Introduction
Fortunately, today's challenge was a lot more straightforward than the past few days. In other words, I actually understood the prompt. My current background and interests involve file parsing, so this one was right up my alley.

# Part 1
### Basic concept
The prompt to solve for was the number of lit pixels. While I could've done a simpler solution that only counts the # of potential lit pixels, I always like to visually see these solutions. Additionally, the fact that we must iterate more than once based on adjacent pixels made the storage of each current version of the "enhanced" image seem necessary. Overall, each "enhancement" had the following for each pixel:
#### 1. Get the enhancement array
This was the cardinal direction neighbors of a given point. I was able to once again refactor my `cardinal_directions` logic from previous solutions to serve this purpose. The logic is useful, as it already handles boundary cases. Previously, I had defaulted to returning a bogus number if a direction was out of bounds, and this logic served itself nicely given that our image was "infinite." In other words, if it's out of bounds, return the pixel color of the ocean floor (more on that later.) This is handled in `get_enhancement_array`.
#### 2. Decode this array to binary and then find that value in our enhancement key
The logic here in `decode_enhancement_array` is more or less outlined in the prompt for today. From there, it was a simple index based reference to our enhancement key.
#### 4. Replace the pixel with the new version
This decoded pixel would then be pushed into a new row for the new image.

### Handling infinite space
A bit of the challenge was that for the image to grow when being enhanced, we assume the image is infinite. What I found this to mean is that we have to decode the pixels at least 1 index away from our image. Otherwise, the image cannot grow in size. It will just flip pixels back and forth. Just to be safe, my solution includes pixels at least 2 indices away from the image. For example, given the image:

`#..#.`

`#....`

`##..#`

`..#..`

`..###`

we actually need to enhance the following:

`     ` --> `.........`

`     ` --> `.........`

`#..#.` --> `..#..#...`

`#....` --> `..#......`

`##..#` --> `..##..#..`

`..#..` --> `....#....`

`..###` --> `....###..`

`     ` --> `.........`

`     ` --> `.........`

This logic was handled in `simulate_infinite_space`. Essentially, we're simulating the pixel enhancement for the infinite space by adding a couple of "infinite space"-ish pixels. This worked perfectly for the test data, but it did not work on the actual data.

#### Flickering
Debugging using `print_image` for each enhancement iteration revealed my extra "padded" areas around the image for simulating infinite space weren't a consistent character. They were either all `#` or a mixture of `.` and `#`. Then I realized an error in my base assumption:
- I had assumed that the ocean floor would always be read as a `.` pixel since `000000000` decodes to `0`, and `0` in the test data enhancement key was `.` 

A quick investigation into the actual data's enhancement key revealed that `0` was `#`. What this means is that if the `0` index of the enhancement key is a `#`, the pixel for our simulated infinite ocean floor will actually "flicker" between `.` and `#` every other iteration. Because of this, I had to replace all of my hardcoded `.` padding logic to be a dynamic `padding_char` value. From there, we could just apply some logic to determine which "flicker character" to use for our simulated infinite ocean padding. This solution worked splendidly.

# Part 2
The dreaded "your Part 1 solution for small iterations solution was great, but what if we turn it up to 11" prompt. While my Part 1 solution did take slightly longer to run at `50` enahncements, the data structures and enhancement logic I used in Part 1 for `2` enchancements held up. 

# Conclusions
Given that we had to iterate over the resultant "enhancements" over time, I'm not sure how my solution method could be improved. This was one of those days that required iterating over every option. I think this solution is fairly lean when it comes to storing data and handling the infinite image trickiness by only storing portions of the image that are relevant to our enhancements
