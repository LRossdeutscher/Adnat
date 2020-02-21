# Adnat (Ruby on Rails challenge) Submission

This repository includes my submission for the Tanda backend programming challenge as part of their application for a Full Stack Developer position.

Before beginning with the implementation of my submission, I first had to setup a the Ruby on Rails environment on my laptop. I followed the instructions listed in [this tutorial](https://gorails.com/setup/windows/10).

Below is a brief description pulled from the task spec, and below that is a list of the optional exercises that I attempted and implemented and also the ones I did not. The ones I did not have a small discussion about how I may have implemented if I had longer time to work on this.

## Brief Description

For this challenge you will be creating highly simplified version of the Tanda web app from scratch using [Ruby on Rails](https://rubyonrails.org/). This is a Ruby on Rails challenge, so you don't need to worry about design too much. You should use Git as you build your solution. 

### Optional exercises completed

#### 1. Users details (easy)
Users can change their own name and email address.

#### 2. Modifying/Deleting shifts (easy)
Users can modify or delete their own existing shifts.

#### 5. Overnight shifts (medium)
When creating a shift, if the finish time of a shift is earlier than the start time, the shift is be considered to be overnight. For example, if the start time is 7:30pm and the finish time is 1:30am, then it is an overnight shift that goes for 6 hours.

#### 6. Penalty rates on Sundays (medium)
The hourly rate should is doubled for shifts worked on a Sunday. Overnight shifts are accounted for in the following manner: The 2x is only apply to the hours worked on Sunday. For the sake of simplicity, the break length is subtracted from the end of the shift, as in the given example:

| start | finish | break length | shift cost (assuming $10 hourly rate) |
| - | - | - | - |
| 10pm Sunday | 3am Monday | 1 hour | $60 (5h at work – 1h break = 2h worked on Sunday and 2h worked on Monday) |
| 5pm Sunday | 2am Monday | 2 hours | $140 (9h at work – 2h break = 7h worked on Sunday) |
| 9pm Sunday | 1am Monday | 2 hours | $40 (4h at work – 2h break = 2h worked on Sunday) |

Nevertheless, looking on the bright side my bash script is a nice way of summarizing and saving the test output.

#### 9. Unit tests
For unit tests, I followed the guidelines contained within [this tutorial](https://guides.rubyonrails.org/v3.2/testing.html). I've implemented some basic unit tests for the models, controllers and one integration test. These are briefly described in [their sections](https://github.com/LRossdeutscher/Adnat/blob/master/README.md#models) below. To help with running all the tests at once, I also created a short bash script which can be found in the test/ directory, and run from within the test/ directory as follows.
```bash
./run_all_tests.sh
```
The script runs each test file in the models, controllers and integration directories and pipes their outputs to corresponding output files stored under the test_output/ directory (also in the test/ directory).
I then discovered that Rails comes with a number of rake tasks to help in testing. The table below lists all rake tasks that come along in the default Rakefile when you initiate a Rails project.
| Tasks | Description |
| - | - |
| rake test |	Runs all unit, functional and integration tests. You can also simply run rake as the test target is the default. |
| rake test:benchmark |	Benchmark the performance tests |
| rake test:functionals |	Runs all the functional tests from test/functional |
| rake test:integration |	Runs all the integration tests from test/integration |
| rake test:profile |	Profile the performance tests |
| rake test:recent |	Tests recent changes |
| rake test:uncommitted |	Runs all the tests which are uncommitted. Supports Subversion and Git |
| rake test:units |	Runs all the unit tests from test/unit |

Nevertheless, my script is still useful for saving the outputs for the model, controller and integration tests seperately. 

##### Models:
Basic blackbox test cases for each model listed in the schema. 
1. A test for creating a valid record
2. Validation tests for attributes

##### Controllers:
Both black and whitebox test cases are included. Tests views and basic routing. 

##### Integration:
Tests the typicall user flow as seen in the [demo video](https://www.youtube.com/watch?v=A8u8tBWoM4k) included at the bottom of the tassk spec.

### Incomplete Exercises

#### 3. Departed Employee Shift Storage (easy)
Create a way for shifts of a departed employee to be stored. Create a link on the "View Shifts" route that would direct a user to a table of prior employees shifts. You may need to make schema changes for this exercise. Bonus: If a departed employee re-joins the organisation, have a way for their past shifts to be re-added to current shifts.
##### Potential Approach: 
Currently, when a user leaves an organisation, all their shifts remain linked to their user_id. This means that, upon joining another organistion, their previous shifts are automatically included and become part of the new organisation. To make this work, along with the multiple organisations, the schema would need to be changed such that shifts belong_to organisations and users has_many shifts through organisations. Additionally, an old_shifts relation can be implemented, belonging to organisations as well to contain the departed employee shifts.

#### 4. Filtering shifts (medium)
Allow users to filter which shifts are visible based on employee or a date range or both.

#### 7. Multiple breaks (tricky)
People often take more than one break when they work. For this exercise, instead of a shift having a single break length, it could have multiple. The sum of all these should be taken into account when calculating `hours worked` and `shift cost`.
##### Potential Approach:
My idea (guess) for this is to include a nested form of some sort that asks the user for any amount of break_minutes in the respective cell in the shifts table. There would be one input, as is currently, and an option to add another break. Adding another break would display a second input for break_minutes where the user can input their desired break minutes for the second break. This can then go on for an arbitrary amount of breaks. Upon submitting the forms, the nested form is simply evaluated to be the sum of all the individual break minutes and that result is placed in the outer original form. 

#### 8. Multiple organisations (tricky)
Some people have 2+ jobs. Extend organisation functionality to allow users to belong to more than one organisation. You will need to rethink the shifts model. Shifts currently belong to a user (who belongs to a single organisation). If there are multiple organisations involved, this falls apart, because you don't know which organisation the user worked the shift at.
##### Potential Approach:
The schema would need to be changed to something that would reflect the behaviour mentioned for the Departed Employee Shift storage exercise. By having this schema, the user can be a member of multiple organisations whilst having different shifts for each organisation.
