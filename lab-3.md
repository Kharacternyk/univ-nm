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
def report(p):
    sample = linspace(-6, 6)
    plot(sample, f(sample))
    plot(sample, p(sample))
    grid(True)
    show()

    sample = linspace(x_first, x_last)
    fs = f(sample)
    ps = p(sample)

    plot(sample, fs)
    plot(sample, ps)
    grid(True)
    show()

    plot(sample, fs - ps)
    grid(True)
    show()
```

### Обчислення розділених різниць

```python
diff_cache = {}

def diff(xs):
    if not xs in diff_cache:
        if len(xs) > 1:
            diff_cache[xs] = (diff(xs[1:]) - diff(xs[:-1])) / (xs[-1] - xs[0])
        else:
            diff_cache[xs] = f(xs[0])
    return diff_cache[xs]
```

### Обчислення поліному Н'ютона за схемою Горнера

```python
def horner_p(x, xs):
    result = diff(xs)
    for i in range(x_count - 1):
        result *= x - xs[i + 1]
        result += diff(xs[i + 1:])
    return result
```

### Поліном Н'ютона з рівновіддаленими вузлами

```python
uniform_xs = tuple(
    x_first + (x_last - x_first) * (i / (x_count - 1))
    for i in range(x_count)
)

report(lambda x: horner_p(x, uniform_xs))
```

### Поліном Н'ютона з вузлами у нулях полінома Чебишова

```python
chebyshev_xs = tuple(
    (x_first + x_last) / 2 +
    (x_last - x_first) * cos(pi * (2 * i + 1) / (2 * (x_count + 1))) / 2
    for i in range(x_count)
)

report(lambda x: horner_p(x, chebyshev_xs))
```


<style>
    body {
        font-family: sans-serif;
    }
    .MathJax * {
        color: inherit !important;
    }
</style>
