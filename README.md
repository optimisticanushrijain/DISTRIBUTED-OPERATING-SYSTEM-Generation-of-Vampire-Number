# Proj1

The overall goal of your program is to find all vampire numbers starting at N1 and up to N2 using use Elixir and the actor model to build a good solution to this problem that
runs well on multi-core machines.

Technology Used: Elixir, Atom

1. Group Members :
Chirag Maroke (UFID 1595-7951) && Anushri Jain (UFID - 8764-6425)

Steps to run the code:
(a) Run the project by giving the commands: 'mix run proj1.exs [arg1] [arg2]' - for regular output 'time mix run proj1.exs [arg1] [arg2]' - to display time & regular output.

2) The number of worker actors that we have created:


3) Size of the work unit of each worker actor: 
The work unit has been decided after trying out with different values and optimizing it. The following logic is being used to find work unit based on input:

Taking log to the base 10 of the input size (n). This integer number is then halved & the work-unit is considered as -

work-unit = 10^(number)

eg. if n = 1,000,000

so, log(10^6) to base 10 => 6

work-unit = 10^(6/2) = 10^3.

So, in this case we've taken size of work-unit as 1,000 for an input(n) of 1,000,000

4) The result of running your program for: mix run proj1.exs 1000000  4(Running Time)

5) REAL TIME = s 
   CPU TIME = 
   CPU TIME /REAL TIME =

6) The largest problem we managed to solve:  mix run proj1.exs 1000000000 4
