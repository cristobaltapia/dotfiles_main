#!/usr/bin/env python3
from datetime import date
from textwrap import fill, wrap, shorten
import numpy as np

import pandas as pd

MONTHS = {
    "Januar": 1,
    "Februar": 2,
    "März": 3,
    "April": 4,
    "Mai": 5,
    "Juni": 6,
    "Juli": 7,
    "August": 8,
    "September": 9,
    "Oktober": 10,
    "November": 11,
    "Dezember": 12
}


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
    curr_year = date.today().year
    curr_month = date.today().month
    next_year = curr_year + 1
    list_plan = ""

    for year_i in [curr_year, next_year]:
        list_plan += "\n" + "".ljust(5) + "<b>" + f"{year_i}".ljust(width) + "</b>\n"

        for month_i in data.index:
            elements_i = str(data.loc[month_i, year_i]).split("/")

            if MONTHS[month_i] == curr_month and year_i == curr_year:
                color_month = "#bf616a"
            else:
                color_month = "#eceff4"

            if year_i == curr_year:
                color_year = "#81a1c1"
            else:
                color_year = "#ebcb8b"

            month_str = shorten(f"{month_i}", 3, placeholder="") + "  "
            month_str = f'<span foreground="{color_month}">{month_str}</span>'

            list_year = []

            for ele_i in elements_i:
                if ele_i == "nan":
                    entry_month = "".ljust(width)
                else:
                    entry_month = shorten(str(ele_i), width).ljust(width)

                list_year.append(entry_month)

            start = "".ljust(5)
            for l, e in enumerate(list_year):
                month_entry = f'<span foreground="{color_year}">{e}</span>'
                if l > 0:
                    list_plan += f"{start}{month_entry}\n"
                else:
                    list_plan += f"{month_str}{month_entry}\n"


    base = f"""<span face="monospace">
<span foreground="#eceff4">
{list_plan[1:-1]}
</span>
</span>"""

    return base


if __name__ == "__main__":
    main()
