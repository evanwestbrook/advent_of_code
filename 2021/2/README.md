# Introduction
Today's code challenge was pretty fun to imagine: a submarine piloting system. Part 1 and Part 2 were both closely related, so I won't split up the solution here.

# Approach
The answer to each part of this challenge was to perform some math based on the final position after plotting a course. This involved a few key items:

#### Reading the Data
I'm a big fan of storing lists of hashes in Ruby. It's probably a result of my time working with Workato earlier in my career. It's a great way to use Ruby's powerful enumerable methods. Because of this, I stored my list of submarine commands in a list with the following basic format:
`[{ command: "forward", "down", "up", etc., unit: integer for units moved with command }, ...]`
This structure also makes the commands rather scalable. We can easily handle new direction commands and other unit types/conversions. If there are other attributes introduced in each command (i.e. trick: "barrel roll"), we can easily add those in.

#### Object Oriented
I wanted to practice object oriented programming in Ruby today. Because of that, I created a `Submarine` model. There isn't much to this model, but it allows the `Submarine` to pilot itself. This is advantageous, as any updates to the way that a `Submarine` processes commands (like Part 2!) can be easily tracked. It's also useful, as the `Submarine` knows where it is so we don't have to keep track of its location. We can just ask the sub.

From there, we simply feed the `Submarine` the direction commands and see where it ends up!

# Future Improvements
#### Accessing Data
The `Submarine`'s `print_coords` method was largely because I had forgotten how to make the class's attributes available outside of the class. In the future, I would use `attr_accessor` to make those attributes available

#### Sumbarine Method Access
After solving this one, I realized that I could've refactored to make the `Submarine`'s logic more robust. It would be beneficial for the `Submarine` to interpret commands itself. 

For one, it's not as good if we let outside methods tell the `Submarine` what to do. What if a nefarious sea creature figured out how to call `Submarine.forward()`!? This would also allow the `Submarine` to more easily scale to new command attributes. Keeping the example from [Reading the Data](#reading-the-data) in mind, what if we had `trick: "barrel roll"`, and that trick is actually just `forward() --> up() --> down()`? It would make better sense to keep that command interpretation logic within the `Submarine` itself. To refactor this, we would just add a `move(command)` method to the `Submarine` class, and make all existing method (`forward()`, `down()`, `up()`) private methods. 
