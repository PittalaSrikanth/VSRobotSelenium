import argparse
import os
import xml.etree.ElementTree as ET

HTML_TEMPLATE = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Extent-style Test Report</title>
    <style>
        body {{ font-family: Arial, sans-serif; background: #f4f5f7; margin: 0; padding: 0; }}
        .header {{ background: #212121; color: #fff; padding: 20px 30px; }}
        .header h1 {{ margin: 0; font-size: 24px; }}
        .summary {{ padding: 20px 30px; display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 20px; }}
        .card {{ background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); padding: 20px; }}
        .card h2 {{ margin: 0 0 10px; font-size: 18px; }}
        .card p {{ margin: 0; font-size: 32px; font-weight: bold; }}
        .test-table {{ width: 100%; border-collapse: collapse; margin: 0 30px 30px; }}
        .test-table th, .test-table td {{ padding: 12px 15px; border-bottom: 1px solid #e0e0e0; }}
        .test-table th {{ background: #f0f0f0; text-align: left; }}
        .pass {{ color: #3e8635; }}
        .fail {{ color: #d32f2f; }}
        .skip {{ color: #f57c00; }}
    </style>
</head>
<body>
<div class="header">
    <h1>Extent-style Test Report</h1>
</div>
<div class="summary">
    <div class="card"><h2>Total</h2><p>{total}</p></div>
    <div class="card"><h2>Passed</h2><p class="pass">{passed}</p></div>
    <div class="card"><h2>Failed</h2><p class="fail">{failed}</p></div>
    <div class="card"><h2>Skipped</h2><p class="skip">{skipped}</p></div>
</div>
<table class="test-table">
    <thead>
        <tr><th>Suite</th><th>Test Case</th><th>Status</th><th>Elapsed</th></tr>
    </thead>
    <tbody>
        {rows}
    </tbody>
</table>
</body>
</html>
'''

ROW_TEMPLATE = '<tr><td>{suite}</td><td>{name}</td><td class="{status_class}">{status}</td><td>{elapsed}</td></tr>'


def parse_output_xml(path):
    tree = ET.parse(path)
    root = tree.getroot()
    stats = {'total': 0, 'passed': 0, 'failed': 0, 'skipped': 0}
    rows = []

    suite_names = {suite.get('id'): suite.get('name') for suite in root.findall('.//suite')}

    for test in root.findall('.//test'):
        name = test.get('name')
        status_node = test.find('status')
        status = status_node.get('status') if status_node is not None else 'UNKNOWN'
        elapsed = status_node.get('elapsed', '0') if status_node is not None else '0'
        elapsed = format_elapsed(elapsed)

        suite_id = test.get('id')
        if suite_id and '-' in suite_id:
            parent_id = '-'.join(suite_id.split('-')[:-1])
            suite = suite_names.get(parent_id, 'Unknown')
        else:
            suite = 'Unknown'

        stats['total'] += 1
        status_lower = status.lower()
        if status_lower == 'pass':
            stats['passed'] += 1
        elif status_lower == 'fail':
            stats['failed'] += 1
        elif status_lower in ('skip', 'skipped'):
            stats['skipped'] += 1
        else:
            stats.setdefault(status_lower, 0)
            stats[status_lower] += 1

        rows.append({
            'suite': suite,
            'name': name,
            'status': status,
            'status_class': status_lower,
            'elapsed': elapsed,
        })

    return stats, rows


def format_elapsed(value):
    try:
        seconds = float(value)
    except (TypeError, ValueError):
        return '00:00'
    minutes = int(seconds // 60)
    seconds = int(seconds % 60)
    return f"{minutes:02d}:{seconds:02d}"


def generate_report(input_path, output_path):
    stats, rows = parse_output_xml(input_path)
    row_html = '\n        '.join(
        ROW_TEMPLATE.format(**row)
        for row in rows
    )
    html = HTML_TEMPLATE.format(
        total=stats['total'],
        passed=stats['passed'],
        failed=stats['failed'],
        skipped=stats['skipped'],
        rows=row_html,
    )
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(html)


def main():
    parser = argparse.ArgumentParser(description='Generate a simple Extent-style HTML report from Robot output.xml')
    parser.add_argument('-i', '--input', required=True, help='Path to Robot output.xml')
    parser.add_argument('-o', '--output', required=True, help='Path to output HTML report')
    args = parser.parse_args()
    generate_report(args.input, args.output)


if __name__ == '__main__':
    main()
