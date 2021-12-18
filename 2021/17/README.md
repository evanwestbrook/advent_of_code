# Initial Thoughts
The first item to complete for this challenge was how to model the trajectory of the probe. A key concept when evaluating these approaches was to minimize the number of potential trajectory calculations we had to evaluted. Given that we know the target area we want to hit, we could ideally use those coordinates instead of trying an infinite number.

### Physics
Trajectory is a basic concept in physics. The thought here was that if we use an established formula for trajectory, we could use algebra to modify the formula to solve for our initial velocities (since we know the final target point.) I did some research into [trajectory calculuation formulas](https://www.omnicalculator.com/physics/trajectory-projectile-motion). The basic trajectory formula can be modeled as:

`y = h + xtan(α) - gx²/2V₀²cos²(α)`

When it came to updating this formula, I looked what values we actually knew. We could calculate our inital `α` (angle of launch) value based on our initial velocities. However, we started running into items we did not know. For example, `g` stands for the [gravitational constant](https://www.cuemath.com/trajectory-formula/) on earth. This problem is for underwater. The model outlined in this problem has its own homebrew method of `g` which is `velocity(x) - 1` which doesn't quite fit here. Additionally, the outlined in this problem includes some form of forward wind resistance in the form of `velocity(y)`. These basic trajectory formulas don't model wind resistance (something my Physics PhD father would always lament.)

Based on this, I decided that a simple trajectory formula would not be the correct approach. It was modeled based on something different.

### Modeling the probe
The next approach I considered was just modeling the trajectory of a probe as outlined in the problem statement. This model is ultimately what I went with for modeling trajectory

# Part 1
Still wanting to minimize the # of calculations we would have to make to determine the starting velociyt resulting in the maximum height, I tried to create an approach that used what we knew about the target area.

### The Parabolic Model and "Sighting In"
I considered the model of a parobolic arc. In theory, the highest parabolic arc would come from the highest y velocity of the minimum x velocity that would result in a hit of the target area. In other words, the [x,y] velocity combination that would hit the bottom left corner of our target area. We couldn't determine that velocity, but we could, in theory, calculate the x velocity resulting in a hit on the first step if y = 0. From there, we could start increasing the y velocity until we missed. In other words, we would hit our ideal target spot (min target(x), min target(y)), and then start "sighting in" our solution like an artillery person. That basic starting velocity would be:

`[0 - target(y).min, 0]`

From there, we could just do something like the following, right?

`i = 0; while hit? do { [0 - target(y).min, i + 1] }`

Wrong. This worked for the test data, but the solution stopped after the first probe evaluation where the y height wouldv'e been the lowest. "What gives," I wondered. After doing some scratch paper work, I realized that the lowest left point is just what would usually result in the highest parabola. If increased y velocity resulted in a miss (`!hit?`), then an increase in x could still result in a higher parabola that we should keep evaluating.

Long story short, I tried many different means to continue my loop and keep evaluating. It kept not working. My loop would stop too soon. Or it would encounter a memory error. Or my "don't evaluate out of bounds" logic would not be correct. I admit that at this point, I had spent way too much time on trying to figure this solution out. I cut my losses and realized that I did know two things:
1. An ideal-ish starting velocity
2. A probe trajectory model that was correct

To determine the velocity resulting in a maximum height, I manually "sighted in" my probe trajectory.  For each launch, I wrote down the maximim height and tried again. After a few wrong answer submissions, I came up with the right answer.
