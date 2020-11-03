# EETF Parser
Basic handrolled parser for the External Erlang Term Format written in Elixir. You likely don't want to use this as it was created just for fun. It only supports a handful of terms and none of the extra options that the Erlang version provides.

The EETF (External Erlang Term Format) is a binary serialization protocol that comes out-of-the-box with Erlang. Encoding is as simple as calling `:erlang.term_to_binary/1` and passing a term to encode. For decoding call `:erlang.binary_to_term/1` passing the encoded value.

The actual `term_to_binary` implementation is a BIF (builtin function) which explains the difference in performance.

## Benchmark
to see how horribly it performs I ran a benchmark using Benchee. 
<details>

<summary>The results:</summary>

```
##### With input atom #####
Name                 ips        average  deviation         median         99th %
builtin           4.17 M      239.56 ns   ±663.39%           0 ns         990 ns
handrolled        3.28 M      305.19 ns  ±7572.11%           0 ns         990 ns

Comparison: 
builtin           4.17 M
handrolled        3.28 M - 1.27x slower +65.63 ns

##### With input empty_list #####
Name                 ips        average  deviation         median         99th %
builtin           5.97 M      167.60 ns   ±804.25%           0 ns         990 ns
handrolled        5.36 M      186.64 ns  ±9339.09%           0 ns         990 ns

Comparison: 
builtin           5.97 M
handrolled        5.36 M - 1.11x slower +19.04 ns

##### With input int32 #####
Name                 ips        average  deviation         median         99th %
builtin           5.94 M      168.41 ns   ±802.74%           0 ns         990 ns
handrolled        5.16 M      193.85 ns ±12993.43%           0 ns         990 ns

Comparison: 
builtin           5.94 M
handrolled        5.16 M - 1.15x slower +25.44 ns

##### With input int_8 #####
Name                 ips        average  deviation         median         99th %
builtin           6.03 M      165.75 ns  ±1480.06%           0 ns         990 ns
handrolled        5.21 M      191.92 ns ±13193.42%           0 ns         990 ns

Comparison: 
builtin           6.03 M
handrolled        5.21 M - 1.16x slower +26.17 ns

##### With input map #####
Name                 ips        average  deviation         median         99th %
builtin           4.65 M      214.83 ns  ±7919.91%           0 ns         990 ns
handrolled        2.23 M      447.47 ns  ±5876.13%           0 ns         990 ns

Comparison: 
builtin           4.65 M
handrolled        2.23 M - 2.08x slower +232.64 ns

##### With input non_empty_list #####
Name                 ips        average  deviation         median         99th %
builtin           4.26 M      234.62 ns ±10145.14%           0 ns         990 ns
handrolled        1.93 M      518.00 ns  ±4600.87%           0 ns         990 ns

Comparison: 
builtin           4.26 M
handrolled        1.93 M - 2.21x slower +283.38 ns

##### With input string #####
Name                 ips        average  deviation         median         99th %
builtin           5.84 M      171.25 ns  ±1186.02%           0 ns         990 ns
handrolled        4.14 M      241.59 ns  ±9543.11%           0 ns         990 ns

Comparison: 
builtin           5.84 M
handrolled        4.14 M - 1.41x slower +70.34 ns

##### With input struct #####
Name                 ips        average  deviation         median         99th %
builtin           1.82 M        0.55 μs  ±1415.28%        0.99 μs        0.99 μs
handrolled        0.89 M        1.12 μs  ±1534.22%        0.99 μs        1.99 μs

Comparison: 
builtin           1.82 M
handrolled        0.89 M - 2.03x slower +0.57 μs
```
</details>
