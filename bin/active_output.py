#!/bin/python

import asyncio
from i3ipc.aio import Connection

async def main():
    i3 = await Connection().connect()
    outputs = await i3.get_outputs()
    for output in outputs:
        if output.focused:
            print(output.name)
            return

asyncio.run(main())
