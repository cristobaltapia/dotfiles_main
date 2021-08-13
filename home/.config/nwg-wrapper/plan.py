#!/usr/bin/env python
from datetime import date
from textwrap import fill, wrap, shorten
import numpy as np

import pandas as pd


def main():
    # Read plan
    plan = pd.read_excel("~/Nextcloud/five_year_plan.xlsx", index_col=0)

    out = format_output(plan)
    print(out)


def format_output(data):
    """Format to correct pango markup.

    Parameters
    ----------
    data : TODO

    Returns
    -------
    TODO

    """
    width = 34
    year = date.today().year
    next_year = year + 1
    list_plan1 = "".ljust(5) + f"{year}".ljust(width) + "\n"
    list_plan2 = "".ljust(5) + f"{next_year}".ljust(width) + "\n"

    for k in data.index:
        elements_1 = str(data.loc[k, year]).split("/")
        elements_2 = str(data.loc[k, next_year]).split("/")

        month = shorten(f"{k}", 3, placeholder="") + "  "

        list_1 = []
        list_2 = []

        for j, e in enumerate(elements_1):
            if e == "nan":
                m1 = "".ljust(width)
            else:
                m1 = shorten(str(e), width).ljust(width)

            list_1.append(m1)

        for j, e in enumerate(elements_2):
            if e == "nan":
                m2 = "".ljust(width)
            else:
                m2 = shorten(str(e), width).ljust(width)

            list_2.append(m2)

        start = "".ljust(5)
        for l, e in enumerate(list_1):
            month1 = f'<span foreground="#81a1c1">{e}</span>'
            if l > 0:
                list_plan1 += f"{start}{month1}\n"
            else:
                list_plan1 += f"{month}{month1}\n"

        for l, e in enumerate(list_2):
            month2 = f'<span foreground="#ebcb8b">{e}</span>'
            if l > 0:
                list_plan2 += f"{start}{month2}\n"
            else:
                list_plan2 += f"{month}{month2}\n"

    base = f"""<span face="monospace">
<span foreground="#eeeeee">
{list_plan1}
{list_plan2[:-1]}
</span>
</span>"""

    return base

if __name__ == "__main__":
    main()
