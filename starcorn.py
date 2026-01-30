#!/usr/bin/env python3

USAGE_STR=f"Usage: ./starcorn.py staticdir [UVICORN_OPTIONS: --host, --port, --help, etc.]"

import os
import sys
from pathlib import Path

import uvicorn
from starlette.applications import Starlette
from starlette.routing import Mount
from starlette.staticfiles import StaticFiles

class StarletteApp(Starlette):
    def __init__(self):
        routes = [
            Mount('/', app=StaticFiles(directory=os.environ.get("STARCORN_STATICDIR", ""), html=True))
        ]
        super().__init__(routes=routes)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(USAGE_STR)
        sys.exit(1)
    else:
        for arg in sys.argv:
            if arg == "--help":
                print(USAGE_STR)
                # prints uvicorn help
                uvicorn.main()
                exit(0)

        staticdir = Path(sys.argv[1])
        assert staticdir.exists() and staticdir.is_dir(), "First argument must be a static files directory or `--help`"
        os.environ["STARCORN_STATICDIR"] = sys.argv[1]

        # pass residual arguments to uvicorn and run
        sys.argv.pop(1)
        sys.argv.insert(1, f"{Path(__file__).stem}:StarletteApp")
        sys.argv.append("--factory")
        uvicorn.main()
