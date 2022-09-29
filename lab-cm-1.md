# Комп'ютерне моделювання <br> Лабораторна робота №1
###### Віннічук Назар <br> МІ-3

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
    return (
        step(bounds, node_count) * (
            function(bounds[0]) / 2 +
            function(bounds[1]) / 2 +
            sum(map(function, nodes(bounds, node_count)[1:-1]))
        )
    )
```

```python
runge(lambda x: 4 / (1 + x**2), (0, 1), 5e-6, 1, integrate_via_left_rectangles)
```
```python
runge(lambda x: 4 / (1 + x**2), (0, 1), 5e-6, 2, integrate_via_trapezoids)
```

<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
