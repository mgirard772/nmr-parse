# Install repo Python version
echo "Installing Python version $(cat .python-version)"
pyenv install -s

echo "Setting up Python virtual environment"

if [ ! -d .venv ]; then
  python3 -m venv .venv
fi

source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt