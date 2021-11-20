import datetime, time

ups_data = open('apcupsd.events', 'r')
start, end = 0, 0
with open('stamps.csv', 'w+') as csv_file:
    for line in ups_data:
        blocks = line.split()
        if blocks[3] == "Power":
            bonus = 10800 if (int(blocks[2]) == 300) else 7200
            a_date, a_time = blocks[0].split('-'), blocks[1].split(':')
            year, month, day = int(a_date[0]), int(a_date[1]), int(a_date[2])
            hour, minute, sec = int(a_time[0]), int(a_time[1]), int(a_time[2])
            t = datetime.datetime(year, month, day, hour, minute, sec)
            timestamp = (int(time.mktime(t.timetuple())) - bonus)
            if blocks[4] == 'failure.':
                if start > 0:
                    csv_file.write(f"{start},2\n")
                start, end = timestamp, 0
            elif blocks[4] == 'is':  # 'is' - 'is back.'
                csv_file.write(f"{start},{timestamp - start}\n")
                start = 0
csv_file.close()
ups_data.close()

csv_data = open('stamps.csv', 'r')
step, start, value = 300, None, None
with open('data.csv', 'w+') as csv_file:
  for line in csv_data:
      cur_line = line.split(',')
      stop = int(cur_line[0])
      if start != None and value != None and start < (stop - 1):
        if start != start + value:
          for i in range(start, start + value, step):
            csv_file.write(f"{i*1000},{value*1000}\n") # "*1000" sest JS kasutab milisekondit epochis"
        for j in range(start + value, stop - 1, step):
          csv_file.write(f"{j*1000},0\n")
      start, value = int(cur_line[0]), int(cur_line[1].rstrip()) # rstrip selleks et kustuta "\n"
csv_data.close()