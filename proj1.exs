defmodule Proj1 do
  use GenServer
  @moduledoc """
  Documentation for Proj1.
  """

  @impl true
  def init(args) do
    {:ok, args}
  end

  @doc """
  Handle async calls
  """
  @impl true
  def handle_cast({:subtask, n1, n2, parentPID}, state) do
    result = print_multiple_times(n1, n2)
	  result = result |> elem(1)
	  send(parentPID, result)
    {:noreply, [state]}
  end


  def print_multiple_times(n1, n2) when n1 == n2 do
    s = Integer.to_string(n1)
    len = String.length(s)
    result = if rem(len, 2)==0 do
		permute(s, n1) |> elem(1)
	  else
		""
    end
	  {:ok, result}
  end


  def print_multiple_times(n1, n2) do
    s = Integer.to_string(n1)
    len = String.length(s)
	  result = if rem(len, 2)==0 do
		_result = permute(s, n1) |> elem(1)
		else
			""
    end
	  temp = print_multiple_times(n1+1, n2) |> elem(1)
	  temp1 = if result == "" do
		""
	else
		"\n"
	end
    result = result <> temp1 <> temp
	{:ok, result}
  end

  #####################################################################
  def permute(s,num) do
    _len = String.length(s)

    Enum.sort(String.codepoints("#{num}"))

#The code for vampire number is standard. It meets the condition labeled in the problem statement.
    fangs_of_vampire_number =     Enum.filter(get_factor_pairs(num), fn {fangA, fangB} ->
         digits_count(fangA) == Kernel.trunc(digits_count(num)/2)&& # check for digits in fangA
         digits_count(fangB) == Kernel.trunc(digits_count(num)/2)&& # check for digits in fangB
         Enum.sort(to_charlist("#{fangA}#{fangB}")) == Enum.sort(to_charlist("#{num}")) && #compares digits
         Enum.count([fangA, fangB], fn fang -> rem(fang, 10) == 0 end) != 2 # test for trailing 0s
       end)

   result = if fangs_of_vampire_number != [] do
      a = Enum.map(fangs_of_vampire_number, fn{a,b} ->
        " #{a} #{b} "
      end)
      "#{num} #{a}"
	    else
	   	""
      end
	   {:ok, result}
  end

  def get_factor_pairs(num) do
    mini = :math.pow(10, div(length(to_charlist(num)), 2) - 1) |> Kernel.trunc
    maxa  = :math.sqrt(num) |> round
    for i <- mini .. maxa, rem(num, i) == 0, do: {i, div(num, i)}
  end

  # Find digit count by converting to string. Methods easily available.
  defp digits_count(n) do
     String.length(to_string(n))
   end

  # Supervisor (client) methods

  @doc """
  Use for starting worker actors for the main problem
  """
  def main(n1, n2) do  #This is our starting function of application
    IO.puts "                           -------Chirag Maroke & Anushri Jain!-------"
    IO.puts "                          Welcome to our vampire number finding program!"
  #  n1 = IO.gets "Enter 1st element of range : "
  #  n1 = String.trim(n1)
  #  n1 = String.to_integer(n1)    # convert string to integer

  #  n2 = IO.gets "Enter 2nd element of range : "
  #  n2 = String.trim(n2)
  #  n2 = String.to_integer(n2)

    start_time = :os.system_time(:nanosecond)        #Starting time of application
    workunit = 10  #getWorkUnit(n)                   #worker-process task load variable determined by user of application
    numworkers = getNumOfWorkers(n2-n1, workunit)    #Number of worker processes based on workunit and range
    IO.puts "Number of worker-processes created will be  #{numworkers}"
    loop(numworkers, workunit, n1, n2)
	  result = waitForAllWorkersToFinish(numworkers) |> elem(1)
	  IO.puts result
    stop = :os.system_time(:nanosecond) - start_time
    IO.puts "Time taken to run the code - " <> Integer.to_string(stop)
  end

  @doc """
  Start async processes by using Genserver.cast
  """
  def loop(numworkers, workunit, n1, n2) do
    if numworkers>0 do
      {:ok, pid} = GenServer.start_link(Proj1, [:subtask], [])
      i = n1 + ((numworkers * workunit) - workunit) + 1
      GenServer.cast(pid, {:subtask, i, n2, self()})

      Proj1.loop(numworkers - 1, workunit, n1, i-1)

    end
  end

  @doc """
  Wait for all workers to finish processing all numbers in batches and send response.
  """
  def waitForAllWorkersToFinish(numWorkers) do
	result = if numWorkers>0 do
		msg = receive do msg ->
			msg
		end
		msg = String.trim(msg)
		temp = waitForAllWorkersToFinish(numWorkers-1) |> elem(1)
		temp1 = if msg == "" do
				""
			else
				"\n"
			end
		_msg = msg <> temp1 <> temp
		else
			""
	end
	{:ok, result}
  end


  defp getNumOfWorkers(n,workunit) do
    n/workunit |> Float.ceil |> Kernel.trunc
  end
end

#Run this -

[n1,n2] = System.argv
Proj1.main(String.to_integer(n1), String.to_integer(n2))
