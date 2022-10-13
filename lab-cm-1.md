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
$0.3$ задля досягнення сумарної точності $0.5$. Оцінемо залишковий член:

$$
    f(x) = \frac{1}{\sqrt{x(1+x^2)}}
$$
$$
    f'(x) = -\frac{3x^2 + 1}{2(x^3 + x)^{3/2}}
$$
$$
    |R(f)|
    \le \frac{(\max_{x \in [0.01, 1]}{f'(x)})(1-0.01)h}{2}
    \le \frac{4h}{0.02}
    = 200h
$$
$$
    |R(f)| \le 0.3 \Leftarrow h = 0.001
$$

```python
integrate_via_left_rectangles(lambda x: 1 / (x * (1 + x*x))**0.5, (0.01, 1), 991)
```

#### №29

$$
    \int_0^\infty \ln\tanh\frac{x}{2}\,dx
    = \int_0^\infty \ln\frac{e^x-1}{e^x+1}\,dx
    = \int_0^\infty \frac{e^{-x}}{e^{-x}}\ln\frac{e^x-1}{e^x+1}\,dx
$$

Використаємо поліноми Лагера для $\alpha = 0$:

$$
    L_2^0(x) = x^2 - 4x + 3 = (x-1)(x-3) \Rightarrow x_1 = 1, x_2 = 3 \\
    c_1 = \frac{2!2!}{1(2 - 4)} = \frac{4}{-2} = -2 \\
    c_2 = \frac{2!2!}{3(6 - 4)} = \frac{4}{6} = \frac{2}{3}
$$

```python
def f(x):
    return numpy.log((numpy.exp(x) - 1) / (numpy.exp(x) + 1)) / numpy.exp(-x)

-2 * f(1) + 2/3 * f(3)
```

$$
    |R(f)| \le M_{2n}\frac{2!2!}{4!} = \frac{M_{2n}}{6} = \infty
$$

<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
