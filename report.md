# Чисельні методи. Лабораторна робота №1
### Віннічук Н.Д. К-25
#### Варіант №40

* Досліджуване рівняння: $f(x)=x^3+\sin{x}-12x+1=0$
* Похибка: $\epsilon=10^{-4}$

```python
from matplotlib.pyplot import *
from numpy import *

def f(x):
    return x**3 + sin(x) - 12*x + 1

sample = linspace(-4, 4)
plot(sample, f(sample))
grid(True)
show()
```

<style>
    .mi {
        color: inherit;
    }
</style>
