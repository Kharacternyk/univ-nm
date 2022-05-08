# Чисельні методи <br> Лабораторна робота №3 <br> Варіант №40
###### Віннічук Назар <br> Група К-25

### Досліджувана функція

$$ \mathrm{sh}\,x - 12\,\mathrm{th}\,x - 0.311 $$

### Виділення кореня

```python
from matplotlib.pyplot import *
from numpy import *

def f(x):
    return sinh(x) - 12 * tanh(x) - 0.311

sample = linspace(-6, 6)
plot(sample, f(sample))
grid(True)
show()

sample = linspace(2, 4)
plot(sample, f(sample))
grid(True)
show()
```

$$
f(2) = \frac{e^2 - e^{-2}}{2} - 12\frac{e^2 - e^{-2}}{e^2 + e^{-2}} - 0.311 <
\frac{9 - 0}{2} - 12\frac{6 - 1}{9 + 1} - 0.311 = 4.5 - 6 - 0.311 < 0
$$

$$
f(4) = \frac{e^4 - e^{-4}}{2} - 12\frac{e^4 - e^{-4}}{e^4 + e^{-4}} - 0.311 >
\frac{50 - 1}{2} - 12\frac{81 - 0}{50 + 0} - 0.311 > 24.5 - 24 - 0.311 > 0
$$

$$ f'(x) = \mathrm{ch}\,x - \frac{12}{\mathrm{ch}^2\,x} $$

$$ x > 2 \Rightarrow f'(x) > 2.5 - \frac{12}{6.25} > 0 \Rightarrow f(x)\uparrow $$

### Початкові значення

```python
x_first = 2
x_last = 4
x_count = 10
```

### Вигляд графіків

```python
def report(xs, p):
    fxs = tuple(f(x) for x in xs)

    sample = linspace(x_first, x_last)
    fs = f(sample)
    ps = p(sample, xs, fxs, {})

    plot(sample, fs)
    plot(sample, ps)
    grid(True)
    show()

    inverted_sample = linspace(f(x_first), f(x_last))
    inverted_ps = p(inverted_sample, fxs, xs, {})

    plot(fs, sample)
    plot(inverted_sample, inverted_ps)
    grid(True)
    show()
```

### Обчислення розділених різниць

```python
def diff(xs, fxs, cache):
    if not xs in cache:
        if len(xs) > 1:
            cache[xs] = (diff(xs[1:], fxs[1:], cache) - diff(xs[:-1], fxs[:-1], cache))
            cache[xs] /= xs[-1] - xs[0]
        else:
            cache[xs] = fxs[0]
    return cache[xs]
```

### Обчислення поліному Н'ютона за схемою Горнера

```python
def horner_p(x, xs, fxs, cache):
    result = diff(xs, fxs, cache)
    for i in range(x_count - 1):
        result *= x - xs[i + 1]
        result += diff(xs[i + 1:], fxs[i + 1:], cache)
    return result
```

### Поліном Н'ютона з рівновіддаленими вузлами

```python
uniform_xs = tuple(
    x_first + (x_last - x_first) * (i / (x_count - 1))
    for i in range(x_count)
)
report(uniform_xs, horner_p)
```

### Поліном Н'ютона з вузлами у нулях полінома Чебишова

```python
chebyshev_xs = tuple(
    (x_first + x_last) / 2 +
    (x_last - x_first) * cos(pi * (2 * i + 1) / (2 * (x_count + 1))) / 2
    for i in range(x_count)
)
report(chebyshev_xs, horner_p)
```


<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
