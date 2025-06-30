import os
import re
import csv

log_dir = "./build/results"
output_file = "summary.csv"

table = []

filename_pattern = re.compile(
    r'cache_sim_sets(\d+)_ways(\d+)_block(\d+)_policy_(\w+)\.log'
)

for filename in os.listdir(log_dir):
    filepath = os.path.join(log_dir, filename)
    if not os.path.isfile(filepath):
        continue

    match = filename_pattern.match(filename)
    if not match:
        continue

    sets = int(match.group(1))
    ways = int(match.group(2))
    block_size = int(match.group(3))
    policy = match.group(4)

    hit_rate = None
    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith("Hit rate"):
                parts = line.split(":")
                if len(parts) == 2:
                    hit_rate = float(parts[1].strip())
                break

    if hit_rate is None:
        print(f"Warning: No hit rate found in {filename}")
        continue

    sets_times_ways = sets * ways
    hit_rate_percent = hit_rate * 100

    table.append([policy, sets, ways, sets_times_ways, block_size, hit_rate_percent])

table.sort(key=lambda x: (x[0], x[3], x[4], x[5]))

with open(output_file, 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["Policy", "Sets", "Ways", "Sets*Ways", "Block Size", "Hit rate*100%"])

    last_policy = None
    last_sets_times_ways = None
    last_block_size = None

    for row in table:
        current_policy = row[0]
        current_sets_times_ways = row[3]
        current_block_size = row[4]

        row[5] = f"{row[5]:.2f}"

        # 如果切换到新的 policy 或新的 sets*ways，插空行
        if ((last_policy is not None and last_policy != current_policy) or
            (last_sets_times_ways is not None and last_sets_times_ways != current_sets_times_ways)):
            writer.writerow([])

        # 或在同组里 block_size 发生变化
        elif (last_block_size is not None and last_block_size != current_block_size and
              last_policy == current_policy and last_sets_times_ways == current_sets_times_ways):
            writer.writerow([])

        writer.writerow(row)

        last_policy = current_policy
        last_sets_times_ways = current_sets_times_ways
        last_block_size = current_block_size

print(f"Improved summary with full spacing written to {output_file}")
