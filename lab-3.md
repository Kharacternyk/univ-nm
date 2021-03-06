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
def horner_p(xs, fxs):
    cache = {}
    def compute(x):
        result = diff(xs, fxs, cache)
        for i in range(len(xs) - 1):
            result *= x - xs[i + 1]
            result += diff(xs[i + 1:], fxs[i + 1:], cache)
        return result
    return compute
```

### Вузли інтерполяції

```python
x_first = 2
x_last = 4
x_count = 10
```

### Формат виводу результатів інтерполяцій

```python
from numpy.polynomial.polynomial import Polynomial

def report(xs):
    fxs = tuple(f(x) for x in xs)
    p = horner_p(xs, fxs)
    inverted_p = horner_p(fxs, xs)

    print("Вузли інтерполяції:")
    print(xs, "\n")
    print("Поліном прямої інтерполяції:")
    print(p(Polynomial([0, 1])), "\n")
    print("Поліном оберненої інтерполяції:")
    print(inverted_p(Polynomial([0, 1])))

    sample = linspace(x_first, x_last)
    inverted_sample = linspace(f(x_first), f(x_last))
    fs = f(sample)

    plot(sample, fs)
    plot(sample, p(sample))
    grid(True)
    show()

    plot(fs, sample)
    plot(inverted_sample, inverted_p(inverted_sample))
    grid(True)
    show()
```


### Поліном Н'ютона з рівновіддаленими вузлами

```python
uniform_xs = tuple(
    x_first + (x_last - x_first) * (i / (x_count - 1))
    for i in range(x_count)
)
report(uniform_xs)
```

### Поліном Н'ютона з вузлами у нулях полінома Чебишова

```python
chebyshev_xs = tuple(
    (x_first + x_last) / 2 +
    (x_last - x_first) * cos(pi * (2 * i + 1) / (2 * (x_count + 1))) / 2
    for i in range(x_count)
)
report(chebyshev_xs)
```

### Побудова сплайнів

```python
from numpy.linalg import solve

xs = uniform_xs
h = (x_last - x_first) / (x_count - 1)
hfs = [(f(xs[i]) - 2 * f(xs[i+1]) + f(xs[i + 2])) / h for i in range(x_count - 2)]
a = [[0] * (x_count - 2) for i in range(x_count - 2)]

for i in range(x_count - 2):
    a[i][i] = 2 * h / 3
    if i + 1 < x_count - 2:
        a[i+1][i] = h / 6
        a[i][i+1] = h / 6

ms = [0] + list(solve(array(a), array(hfs))) + [0]

sample = linspace(x_first, x_last)
plot(sample, f(sample))

for i in range(1, x_count):
    def s(x):
        result = 0
        result += ms[i - 1] * ((xs[i] - x) ** 3) / 6
        result += ms[i] * ((x - xs[i - 1]) ** 3) / 6
        result += (f(xs[i - 1]) - ms[i - 1] * h * h / 6) * (xs[i] - x)
        result += (f(xs[i]) - ms[i] * h * h / 6) * (x - xs[i - 1])
        result /= h
        return result

    print(s(Polynomial([0, 1])))
    sample = linspace(xs[i-1], xs[i])
    plot(sample, s(sample))

grid(True)
show()
```


<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
