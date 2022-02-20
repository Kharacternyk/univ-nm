% Numerical methods <br> Lab №1 <br> Variant №40
% Nazar Vinnichuk

### Problem

Equation: $f(x) = x^3 + \sin{x} - 12x + 1 = 0$. <br>
Maximal error: $\epsilon = 10^{-4}$.

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

Let $x \in [0; \frac{\pi}{4}]$. Evaluating the function at the bounds of the
chosen range yields values of different signs:

$$ f(0) = 1 > 0 $$
$$ f(\frac{\pi}{4}) < 1 + 1 - 6 + 1 = -3 < 0 $$

The derivatives are:

$$ f'(x) = 3x^2 + \cos{x} - 12 $$
$$ f''(x) = 6x - \sin{x} $$
$$ f'''(x) = 6 - \cos{x} $$

The first and the second derivative do not change signs at the bounds of the
chosen range:

$$ f'(0) = -11 < 0 $$
$$ f'(\frac{\pi}{4}) < 3 + 1 - 12 = -8 < 0 $$
$$ f''(0) = 0 $$
$$ f''(\frac{\pi}{4}) > 3 - 1 = 2 > 0 $$

From that and $\forall{x} f'''(x) > 0$, one can prove that the first
derivative is negative in the chosen range:

$$
\forall{x} f'''(x) > 0\Rightarrow
f''(x) > 0, x \in [0; \frac{\pi}{4}] \Rightarrow
f'(x) < 0, x \in [0; \frac{\pi}{4}]
$$

### Simple Iteration Method

$$ f(x) = 0 \Rightarrow x = \frac{x^3 + \sin{x} + 1}{12} = \phi(x) $$
$$ \phi'(x) = \frac{3x^2 + \cos{x}}{12} $$
$$ \phi''(x) = \frac{6x - \sin{x}}{12} $$

As $\phi''(x)$ and $\phi'(x)$ are positive in the chosen range, we have:

$$ |\phi'(x)| \leq q = |\phi'(\frac{\pi}{4})| < 1, x \in [0; \frac{\pi}{4}] $$

Let $x_0 = 0.05$.

```python
def phi(x):
    return (x**3 + sin(x) + 1) / 12

def phi_derivative(x):
    return (3*x*x + cos(x)) / 12

epsilon = 1e-4
q = abs(phi_derivative(pi/4))

assert q < 1

def report(i, x):
    print(f"{i}: x = {x:.5f}")

px = x_0 = 0.05
x = phi(px)
n = 1

report(0, x_0)
report(1, x)

while abs(x - px) >= (1 - q) * epsilon / q:
    n += 1
    px = x
    x = phi(px)
    report(n, x)
```

The expected number of iterations is:

```python
int(log(abs(phi(x_0) - x_0) / (1 - q) / epsilon) / log(1/q)) + 1
```

### Newton's Method

Let $x_0 = 0.05$.

$$ f(x_0) > 0 + 0 - 0.6 + 1 > 0 $$

As we have already proved while choosing the range:

$$ f''(x_0) > 0 \Leftarrow x_0 \in [0; \frac{\pi}{4}] $$

Thus:

$$ f(x_0) \cdot f''(x_0) > 0 $$

Which means that $x_n$ will converge to $x_{\star}$ if $x_0 = 0.05$.

As $f''(x)$ is non-negative and $f'(x)$ is negative in the chosen range, we have:

$$ m = \min_{x \in [0; \frac{\pi}{4}]} |f'(x)| = |f'(\frac{\pi}{4})| $$
$$ M = \max_{x \in [0; \frac{\pi}{4}]} |f'(x)| = |f'(0)| = 11 $$

```python
def f_derivative(x):
    return 3*x*x + cos(x) - 12

m = abs(f_derivative(pi/4))
M = 11
q = M * (pi/4 - 0.05) / (2 * m)

assert q < 1

n = int(log2(log((pi/4 - 0.05) / epsilon) / log(1/q)) + 1) + 1

x = 0.05
report(0, x)
for i in range(n):
    x = x - f(x)/f_derivative(x)
    report(i + 1, x)
```

As one can see, the desired precision is already achieved at the first iteration.

<style>
    .MathJax * {
        color: inherit !important;
    }
</style>
