import argparse
from decimal import Decimal, ROUND_HALF_UP
import re


def get_string(d: dict, value_type: str) -> str:
    if d['frequency']:
        return f"{d[value_type]} {d['frequency']}"
    else:
        return f"{d[value_type]}"


def clear_queue(queue: list, parsed_values: list) -> None:
    if len(queue) > 1:
        parsed_values.extend([get_string(d, 'original_value') for d in queue])
    else:
        parsed_values.extend([get_string(d, 'rounded_value') for d in queue])
    queue.clear()


def parse_nmr(nmr_string: str) -> str:
    # replace 'd,' with 'd.' (temporarily)
    nmr_string = nmr_string.replace('d,', 'd.')
    # split on ','
    str_values = nmr_string.split(', ')
    # loop through values
    queue = []
    parsed_values = []
    last_rounded_value = None
    for str_value in str_values:
        split = re.search(r"(\d+\.\d+) ?(\(.*?\))?", str_value)
        value = Decimal(split.group(1))
        rounded_value = value.quantize(Decimal('0.0'), rounding=ROUND_HALF_UP)
        d = {
            'original_value': value,
            'frequency': split.group(2).replace('d.', 'd,') if split.group(2) else None,
            'rounded_value': rounded_value
        }
        if rounded_value == last_rounded_value or last_rounded_value is None:
            queue.append(d)
            last_rounded_value = rounded_value
        else:
            clear_queue(queue, parsed_values)
            last_rounded_value = rounded_value
            queue.append(d)
    clear_queue(queue, parsed_values)
    return ', '.join(parsed_values)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        prog='NVM Signal Parser',
        description='Parses NVM signal values and presents them with the correct decimal representation'
    )
    parser.add_argument('nvm_string')
    args = parser.parse_args()

    print(parse_nmr(args.nvm_string))
