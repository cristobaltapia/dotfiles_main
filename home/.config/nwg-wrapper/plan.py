#!/usr/bin/env python3
from datetime import date
from textwrap import fill, wrap, shorten
from os.path import expandvars
import ruamel.yaml as ryaml
from pandas import DateOffset

yaml = ryaml.YAML(typ="safe", pure=True)

MONTHS = {
    1:"Januar",
    2:"Februar",
    3:"März",
    4:"April",
    5:"Mai",
    6:"Juni",
    7:"Juli",
    8:"August",
    9:"September",
    10:"Oktober",
    11:"November",
    12:"Dezember"
}


def main():
    # Read plan
    with open(expandvars("$HOME/Nextcloud/five_year_plan.yaml"), "r") as stream:
        plan = yaml.load(stream)

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
    start_date = date.today() - DateOffset(months=2)
    start_year = start_date.year
    dates = [start_date + DateOffset(months=k) for k in range(36)]
    iter_dates = [(d.year, d.month) for d in dates]

    prev_year = dates[0].year
    list_plan = '<tt><b>     ' + f"{start_date.year}".ljust(width) + "</b></tt>\n"

    num_elements = 0
    max_elements = 30

    for year_i, month_i in iter_dates:
        if year_i > prev_year:
            list_plan += "\n" + "<tt><b>     " + f"{year_i}".ljust(width) + "</b></tt>\n"
            prev_year += 1

        elements_i = data[year_i][month_i-1][MONTHS[month_i]]

        if month_i == curr_month and year_i == curr_year:
            color_month = "#bf616a"
        else:
            color_month = "#eceff4"

        if year_i == start_year:
            color_year = "#81a1c1"
        elif year_i == start_year + 1:
            color_year = "#ebcb8b"
        else:
            color_year = "#a3be8c"

        month_str = shorten(f"{MONTHS[month_i]}", 3, placeholder="") + "  "
        month_str = f'<span face="monospace" foreground="{color_month}">{month_str}</span>'

        list_year = []

        if elements_i:
            for ele_i in elements_i:
                entry_month = shorten(str(ele_i), width)

                list_year.append(entry_month)
                num_elements += 1
        else:
            entry_month = ""
            list_year.append(entry_month)
            num_elements += 1

        start = '<tt>     </tt>'
        for l, e in enumerate(list_year):
            month_entry = f'<span foreground="{color_year}">{e}</span>'
            if l > 0:
                list_plan += f"{start}{month_entry}\n"
            else:
                list_plan += f"{month_str}{month_entry}\n"

        if num_elements >= max_elements:
            break


    base = f"""<span face="sans">
<span foreground="#eceff4">
{list_plan[:-1]}
</span>
</span>"""

    return base


if __name__ == "__main__":
    main()
