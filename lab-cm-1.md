# Комп'ютерне моделювання <br> Лабораторна робота №1
###### Віннічук Назар <br> МІ-3

#### №1

```python
import numpy


def runge(function, bounds, precision, precision_rank, integrate):
    node_count = 2
    integrals = [
        integrate(function, bounds, node_count),
        integrate(function, bounds, node_count * 2),
    ]
    while abs(integrals[-1] - integrals[-2]) / (2**precision_rank - 1) > precision:
        node_count *= 2
        integrals.append(integrate(function, bounds, node_count * 2))
    return integrals


def step(bounds, node_count):
    return (bounds[1] - bounds[0]) / (node_count - 1)


def nodes(bounds, node_count):
    return numpy.linspace(*bounds, node_count)


def integrate_via_left_rectangles(function, bounds, node_count):
    return step(bounds, node_count) * sum(map(function, nodes(bounds, node_count)[:-1]))


def integrate_via_trapezoids(function, bounds, node_count):
    xs = nodes(bounds, node_count)
    return (
        step(bounds, node_count) * (
            function(xs[0]) / 2 +
            function(xs[-1]) / 2 +
            sum(map(function, xs[1:-1]))
        )
    )


def integrate_via_simpson(function, bounds, node_count):
    xs = nodes(bounds, node_count)
    half_xs = [(xs[i] + xs[i + 1]) / 2 for i in range(len(xs) - 1)]
    return (
        step(bounds, node_count) / 6 * (
            function(xs[0]) +
            function(xs[-1]) +
            4 * sum(map(function, half_xs)) +
            2 * sum(map(function, xs[1:-1]))
        )
    )
```

```python
runge(lambda x: 4 / (1 + x**2), (0, 1), 5e-5, 1, integrate_via_left_rectangles)
```
```python
runge(lambda x: 4 / (1 + x**2), (0, 1), 5e-5, 2, integrate_via_trapezoids)
```
```python
runge(lambda x: 4 / (1 + x**2), (0, 1), 5e-5, 4, integrate_via_simpson)
```

#### №14

$$
    \int_0^1 \frac{dx}{\sqrt{x(1+x^2)}} =
    \int_0^\delta \frac{dx}{\sqrt{x(1+x^2)}} +
    \int_\delta^1 \frac{dx}{\sqrt{x(1+x^2)}} = I_1 + I_2
$$
$$
    I_1 \le \int_0^\delta \frac{dx}{\sqrt{x}} = 2\sqrt{x} \Bigr|_0^\delta
    = 2\sqrt{\delta}
$$

Нехай $\delta = 0.01$, тоді $I_1 <= 0.2$, тоді $I_2$ необхідно обчислити з точністю
$0.3$ задля досягнення сумарної точності $0.5$.

<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>