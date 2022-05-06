% Numerical methods <br> Lab №3 <br> Variant №40
% Nazar Vinnichuk

### Problem

Equation: $\mathrm{sh}\,x - 12\,\mathrm{th}\,x - 0.311 = 0$.

### Segregating the Root

```python
from matplotlib.pyplot import *
from numpy import *

def f(x):
    return sinh(x) - 12 * tanh(x) - 0.311

sample = linspace(-4, 4)
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


<style>
    .MathJax * {
        color: inherit !important;
    }
</style>
