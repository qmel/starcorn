# Starcorn 

Starcorn is a simple asynchronous ([ASGI][asgi]) static files web server based on `starlette` and `uvicorn`

## Dependencies
* `python3` >= 3.8
  * [`starlette`][starlette] ~= 0.31
  * [`uvicorn`][uvicorn] ~= 0.27

Tested on Ubuntu 24.04 LTS, Debian 11 and Windows 7

## Usage

### Running server user-only
```shell
pip install starlette
pip install uvicorn

git clone https://github.com/qmel/starcorn
cd starcorn
./starcorn.py staticdir [UVICORN_OPTIONS: --host, --port, etc.] 
```
`staticdir` will be mounted as the root directory of your website  
`UVICORN_OPTIONS` are arguments passed to `uvicorn` web server, see their [docs][uvicorn-docs] or use `./starcorn.py --help`. By default the server runs on `127.0.0.1:8000`.

### Installing system-wide server service
```shell
sudo apt install python3-starlette
sudo apt install python3-uvicorn

git clone https://github.com/qmel/starcorn
cd starcorn
sudo ./install_service.sh staticdir [UVICORN_OPTIONS: --host, --port, etc.]
```
`starcorn.service` will be put in `systemd` directory and loaded


[asgi]: https://asgi.readthedocs.io/en/latest/
[starlette]: https://github.com/Kludex/starlette
[uvicorn]: https://github.com/Kludex/uvicorn
[uvicorn-docs]: https://uvicorn.dev
