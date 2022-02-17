% Numerical methods <br> Lab №1 <br> Variant №40
% Nazar Vinnichuk

### Problem

Equation: $f(x) = x^3 + \sin{x} - 12x + 1 = 0$ <br>
Maximal error: $\epsilon = 10^{-4}$

### Segregating the Root

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

Let $x \in [0; \frac{\pi}{4}]$.

$$ f(0) = 1 > 0 $$
$$ f(\frac{\pi}{4}) < 1 + 1 - 6 + 1 = -3 < 0 $$
<hr>

$$ f'(x) = 3x^2 + \cos{x} - 12 $$
$$ f''(x) = 6x - \sin{x} $$
$$ f'''(x) = 6 - \cos{x} $$
<hr>

$$ f'(0) = -11 < 0 $$
$$ f'(\frac{\pi}{4}) < 3 + 1 - 12 = -8 < 0 $$
$$ f''(0) = 0 $$
$$ f''(\frac{\pi}{4}) > 3 - 1 = 2 > 0 $$
<hr>

$$
f'''(x) > 0, \forall{x} \Rightarrow
f''(x) > 0, x \in [0; \frac{\pi}{4}] \Rightarrow
f'(x) < 0, x \in [0; \frac{\pi}{4}]
$$

### Simple Iteration Method

$$ f(x) = 0 \Rightarrow x = \frac{x^3 + \sin{x} + 1}{12} = \phi(x) $$
$$ \phi'(x) = \frac{3x^2 + \cos{x}}{12} $$
$$ |\phi'(x)| < \frac{3 + 1}{12}, x \in [0; \frac{\pi}{4}] < 1 $$

Let $x_0 = \frac{1}{2}$

```python
def phi(x):
    return (x**3 + sin(x) + 1) / 12

px = 0.5
x = phi(px)
while abs(x - px) > 1e-4:
    px = x
    x = phi(px)

print(x)
```

<style>
    .mi {
        color: inherit;
    }
</style>
