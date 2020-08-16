from random import randint

lowerBound = input("Enter a lower bound for a range: ")
upperBound = input("Enter an upper bound for a range: ")
while upperBound <= lowerBound:
  upperBound = input("Enter an upper bound larger than the lower bound: ")

print("The lower bound is " + str(lowerBound) + " and the upper bound is " + str(upperBound))

randNum = randint(lowerBound, upperBound)
guess = input("Guess the number (between your given range) I'm thinking of: ")

attempts = 0
while randNum != guess:
  if guess < randNum:
    guess = input("Guess higher: ")
  else:
    guess = input("Guess lower: ")
  attempts += 1

if guess == randNum:
  print("Congrats! You got it in {} attempts.".format(attempts))
else:
  print("Better luck next time.")