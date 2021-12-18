# Initial Thoughts
The first item to complete for this challenge was how to model the trajectory of the probe. A key concept when evaluating these approaches was to minimize the number of potential trajectory calculations we had to evaluted. Given that we know the target area we want to hit, we could ideally use those coordinates instead of trying an infinite number.

#### Physics
Trajectory is a basic concept in physics. The thought here was that if we use an established formula for trajectory, we could use algebra to modify the formula to solve for our initial velocities (since we know the final target point.) I did some research into [trajectory calculuation formulas](https://www.omnicalculator.com/physics/trajectory-projectile-motion). The basic trajectory formula can be modeled as:

`y = h + xtan(α) - gx²/2V₀²cos²(α)`

When it came to updating this formula, I looked what values we actually knew. We could calculate our inital `α` (angle of launch) value based on our initial velocities. However, we started running into items we did not know. For example, `g` stands for the [gravitational constant](https://www.cuemath.com/trajectory-formula/) on earth. This problem is for underwater. The model outlined in this problem has its own homebrew method of `g` which is `velocity(x) - 1` which doesn't quite fit here. Additionally, the outlined in this problem includes some form of forward wind resistance in the form of `velocity(y)`. These basic trajectory formulas don't model wind resistance (something my Physics PhD father would always lament.)
