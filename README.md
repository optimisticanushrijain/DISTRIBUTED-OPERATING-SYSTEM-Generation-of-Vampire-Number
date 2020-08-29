# Proj1

Please mention group members names and UFID. Also write the steps to run your code

1. Group Members :
Chirag Maroke (UFID 1595-7951) && Anushri Jain (UFID - 8764-6425)

2. Steps to run code :
for regular output : mix run proj1.exs [arg1] [arg2]
to display time & regular output : time mix run proj1.exs [arg1] [arg2]

3. Size of the work unit & number of workers :
Work unit will be function be input range & together they determine number of worker actors. We calculated the os:system_time for three ranges - one lakh to two lakh ; 10 lakh to 20 lakh; 1 crore to 2 crore. I found that as the number of actors reached extreme, the performance feel dramatically. And the optimal lay somewhere 100 workers for 1-2 lakh, 1000 workers for 10-20 lakh, and 10000 for 1 crore to 2 crore. For instance : Timings recorded for 1-2 lakh range was : 1.87 sec(1 worker), 0.397 sec(10 worker), 0.3749 sec(100 worker), 0.385 sec(1000 worker), 1.72 sec(10000 worker).

Hence choice of 1000 was hardcoded for work units. But, actual work unit and number of workers should vary according to range. Moreover, we observed that a dynamic allocation of work is required among workers, as the work of a worker dealing with higher range will heavier than those dealing with lower number ranges.


4/5.  The result of running your program for: mix run proj1.exs 100000 200000

With 1000 workers & 100 work units
real	0m1.330s
user	0m6.654s
sys	0m0.229s
CPU ratio : 5.175

With 100 workers & 1000 work units
real	0m0.901s
user	0m3.557s
sys	0m0.171s
CPU ratio : 4.137

With 10000 workers & 10 work unit
real	0m2.795s
user	0m7.539s
sys	0m0.460s
CPU ratio : 2.86

6. As of now, we had tested for 1 to 2 crore for its  CPU ratio and os:system_time. And it gave the fangs for that range.

Time taken to run the code - 239619007000

real	4m0.300s
user	31m19.524s
sys	0m6.495s
CPU Ratio : 31.8/4.03 = 7.89
