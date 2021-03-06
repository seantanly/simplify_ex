defmodule Simplify do
  def simplify(coordinates, tolerance) when is_list(coordinates) do
    simplifyDPStep(coordinates, tolerance * tolerance)
  end

  def simplify(%Geo.LineString{} = linestring, tolerance) do
    %Geo.LineString{coordinates: simplify(linestring.coordinates, tolerance)}
  end

  defp simplifyDPStep(segment, _) when length(segment) < 3, do: segment
  defp simplifyDPStep(segment, toleranceSquared) do
    first = List.first(segment)
    last = List.last(segment)

    {farIndex, _, farSquaredDist} =
      Enum.zip(0..(length(segment)-1), segment)
      |> Enum.drop(1)
      |> Enum.drop(-1)
      |> Enum.map(fn({i, p}) -> { i, p, seg_dist(p, first, last)} end)
      |> Enum.max_by(&(elem(&1, 2)))

    if farSquaredDist > toleranceSquared do
      front = simplifyDPStep(Enum.take(segment, farIndex + 1), toleranceSquared)
      [_ | back] = simplifyDPStep(Enum.drop(segment, farIndex), toleranceSquared)

      front ++ back
    else
      [first, last]
    end
  end

  defp seg_dist({px, py, _}, {ax, ay, _}, {bx, by, _}), do: seg_dist({px, py}, {ax, ay}, {bx, by})
  defp seg_dist(p, a, b), do: Distance.segment_distance_squared(p, a, b)
end
