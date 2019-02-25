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


  def eval_fn(expr, context) do
    IO.inspect(expr, label: "eval> expr")
    case expr do
      ["def", varname, val] -> State.Map.put(context, varname, eval(val, context))
      [func | args] -> (eval(func, context)).(for expr <- args, do: eval(expr, context))
    end
  end

  def eval([expr | _], context) when is_list(expr) do
    eval_fn(expr, context)
  end
  def eval(expr, context) when is_list(expr) do
    eval_fn(expr, context)
  end
  def eval(atom, context) when is_number(atom) do
    atom
  end
  def eval(atom, context) do
    State.Map.get(context, atom)
  end

  def main() do
    {:ok, context} = State.Map.start_link()
    repl(context)
  end

  def repl(context) do
    code = IO.gets "> "
    code
    |> String.trim()
    |> read()
    |> eval(context)
    |> IO.inspect()
    repl(context)
  end

end
