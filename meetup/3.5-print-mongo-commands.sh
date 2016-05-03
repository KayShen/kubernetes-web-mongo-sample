#!/bin/bash

printf 'kubectl --namespace=minefield exec -it mongodb-1-12345 /bin/bash\n'
printf 'mongo\n'
printf 'rs.status()\n'
printf 'rs.initiate()\n'
printf 'rs.status()\n'
printf 'c = rs.conf()\n'
printf 'c.members[0].host = "mongodb-1:27017"\n'
printf 'rs.reconfig(c)\n'
printf 'rs.add("mongodb-2:27017")\n'
printf 'rs.add("mongodb-3:27017")\n'
printf 'rs.status()\n'