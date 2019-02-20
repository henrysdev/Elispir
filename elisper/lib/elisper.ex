defmodule Elisper do

  def atomic(valstr) do
    case Float.parse(valstr) do
      {numeric, _} -> numeric
      _error       -> valstr
    end
  end

  @doc false
  defp expression(["(" | t], accum) do
    {rest, expr} = expression(t, [])
    expression(rest, [expr | accum])
  end
  defp expression([")" | t], accum), do: {t, Enum.reverse(accum)}
  defp expression([], accum), do: Enum.reverse(accum)
  defp expression([h | t], accum), do: expression(t, [atomic(h) | accum])


  def read(code) do
    code
    |> String.replace("(", " ( ")
    |> String.replace(")", " ) ")
    |> String.split()
    |> expression([])
  end

  # def find_n_apply(context, func, args) do
  #   fn_found = State.Map.get(context, func)
  #   case fn_found do
  #     nil -> "Error: undefined reference #{fn_ref}"
  #     _   -> fn_found.(args)
  #   end
  # end

  ## add error handling to denote Undefined Reference Exception
  # def apply(func, args, context) do
  #   State.Map.get(context, func).(for expr <- args, do: eval(expr))
  # end

  def eval([expr | _], context) when is_list(expr) do
    IO.inspect(expr, label: "expr")
    case expr do
      ["def", varname | rest] -> State.Map.put(context, varname, eval(rest, context))
      ["defn", fnname | rest] -> State.Map.put(context, fnname, eval(rest, context))
      [func | args] -> State.Map.get(context, func).(for expr <- args, do: eval(expr, context))
    end
  end
  def eval(atom, context) when is_number(atom) do
    IO.inspect(atom, label: "expr")
    atom
  end
  def eval(atom, context) do
    atom = State.Map.get(context, atom)
    IO.inspect(atom, label: "expr")
    atom
  end

  def main do
    {:ok, context} = State.Map.start_link()
    code = IO.gets "> "
    code
    |> String.trim()
    |> read()
    |> eval(context)
    |> IO.inspect()
    main
  end

end
