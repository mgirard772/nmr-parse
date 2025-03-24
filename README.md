# nmr-parse
This app allows you to input a string of NMR values and get them back with single decimal 
point precision. If a set of adjacent values have the same rounded value, their original precision is preserved.

## How to use
**Input**
```
make run-script args="'158.05 (d, J = 253.6 Hz), 152.26, 138.67, 138.30 (d, J = 8.3 Hz), 138.12, 137.63, 137.44, 128.30, 128.22, 128.03, 127.88, 127.80, 127.75, 127.67, 127.59, 127.55, 124.36 (d, J = 4.1 Hz), 124.05 (d, J = 19.5 Hz), 86.65, 84.30, 80.81, 79.06, 77.77, 75.57, 75.27, 74.89, 73.25, 68.98'"
```

**Output**
```
158.1 (d, J = 253.6 Hz), 152.3, 138.7, 138.3 (d, J = 8.3 Hz), 138.1, 137.6, 137.4, 128.3, 128.2, 128.0, 127.9, 127.80, 127.75, 127.7, 127.59, 127.55, 124.4 (d, J = 4.1 Hz), 124.1 (d, J = 19.5 Hz), 86.7, 84.3, 80.8, 79.1, 77.8, 75.6, 75.3, 74.9, 73.3, 69.0
```

## Set up development environment
1. [Install pyenv](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation)
2. Run `./setup.sh`
3. Run `source .venv/bin/activate`
4. Add the `.venv` environment to your IDE