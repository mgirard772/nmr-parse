# nmr-parse
This app allows you to input a string of NMR values and get them back with single decimal 
point precision. If a set of adjacent values have the same rounded value, their original precision is preserved.

A live version of the app is available at: https://nmr-parse.phendrana.net/
## How to use

### Command Line
**Input**
```shell
make run-script args="'169.78, 159.21, 135.84, 132.33 (d, J = 32.9 Hz), 131.29, 129.95, 127.54, 127.53, 127.51, 127.49, 127.21, 126.53 (qd, J = 24.5, 4.0 Hz), 126.14, 126.12, 123.98, 123.56, 122.55 (tdd, J = 275.0, 28.5, 4.5 Hz), 120.87, 115.12, 113.91, 55.32, 27.19'"
```

**Output**
```text
169.8, 159.2, 135.8, 132.3 (d, J = 32.9 Hz), 131.3, 130.0, 127.54, 127.53, 127.51, 127.49, 127.2, 126.5 (qd, J = 24.5, 4.0 Hz), 126.14, 126.12, 124.0, 123.6, 122.6 (tdd, J = 275.0, 28.5, 4.5 Hz), 120.9, 115.1, 113.9, 55.3, 27.2
```

### App
```shell
make run-app
```

## Set up development environment
1. [Install pyenv](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation)
2. Run `./setup.sh`
3. Run `source .venv/bin/activate`
4. Add the `.venv` environment to your IDE