#!/bin/bash

# Create the services
printf "$ "
sleep 3
printf 'kubectl create --namespace=minefield -f k8s/mongodb.service.yaml\n'
sleep 1
echo 'service "mongodb" created'

printf "$ "
sleep 3
printf 'kubectl create --namespace=minefield -f k8s/mongodb-1.service.yaml\n'
sleep 1
echo 'service "mongodb-1" created'

printf "$ "
sleep 3
printf 'kubectl create --namespace=minefield -f k8s/mongodb-2.service.yaml\n'
sleep 1
echo 'service "mongodb-2" created'


printf "$ "
sleep 3
printf 'kubectl create --namespace=minefield -f k8s/mongodb-3.service.yaml\n'
sleep 1
echo 'service "mongodb-3" created'

# Create the RCs

printf "$ "
sleep 3
printf 'kubectl --namespace=minefield create -f k8s/mongodb-1.rc.yaml\n'
sleep 1
printf 'replicationcontroller "mongodb-1" created\n'

printf "$ "
sleep 3
printf 'kubectl --namespace=minefield create -f k8s/mongodb-2.rc.yaml\n'
sleep 1
printf 'replicationcontroller "mongodb-2" created\n'

printf "$ "
sleep 3
printf 'kubectl --namespace=minefield create -f k8s/mongodb-3.rc.yaml\n'
sleep 1
printf 'replicationcontroller "mongodb-3" created\n'


printf "$ "
sleep 3
printf 'kubectl get pods --namespace=minefield\n'
sleep 1
printf 'NAME                         READY     STATUS    RESTARTS   AGE\n'
printf 'mongodb-1-3fbe1              1/1       Running   0          1m\n'
printf 'mongodb-2-9ig84              1/1       Running   0          20s\n'
printf 'mongodb-3-h8p9t              1/1       Running   0          17s\n'


printf "$ "
sleep 6
printf 'kubectl --namespace=minefield exec -it mongodb-1-3fbe1 /bin/bash\n'
printf 'root@mongodb-1-3fbe1:/# '
sleep 2
printf 'mongo\n'
sleep 1
printf 'MongoDB shell version: 3.2.5\n'
printf 'connecting to: test\n'
printf 'Welcome to the MongoDB shell.\n'
printf 'For interactive help, type "help".\n'
printf 'For more comprehensive documentation, see\n'
printf '	http://docs.mongodb.org/\n'
printf 'Questions? Try the support group\n'
printf '	http://groups.google.com/group/mongodb-user\n'
printf 'Server has startup warnings: \n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] \n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] ** WARNING: Insecure configuration, access control is not enabled and no --bind_ip has been specified.\n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted, \n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] **          and the server listens on all available network interfaces.\n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] \n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] \n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.\n'
printf '2016-04-28T16:05:57.186+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'\n'
printf '2016-04-28T16:05:57.187+0000 I CONTROL  [initandlisten] \n'
printf '2016-04-28T16:05:57.187+0000 I CONTROL  [initandlisten] ** WARNING: soft rlimits too low. rlimits set to 14829 processes, 1000000 files. Number of processes should be at least 500000 : 0.5 times number of files.\n'
printf '2016-04-28T16:05:57.187+0000 I CONTROL  [initandlisten] \n'
printf '> \n'
sleep 2
printf 'rs.status()\n'
sleep 1
printf '{\n'
printf '	"info" : "run rs.initiate(...) if not yet done for the set",\n'
printf '	"ok" : 0,\n'
printf '	"errmsg" : "no replset config has been received",\n'
printf '	"code" : 94\n'
printf '}\n'


printf '> '
sleep 3
printf 'rs.initiate()\n'
sleep 1
printf '{\n'
printf '	"info2" : "no configuration specified. Using a default configuration for the set",\n'
printf '	"me" : "mongodb-1-3fbe1:27017",\n'
printf '	"ok" : 1\n'
printf '}\n'
printf 'rs-minefield:OTHER> '
sleep 3
printf 'rs.status()\n'
sleep 1
printf '{\n'
printf '	"set" : "rs-minefield",\n'
printf '	"date" : ISODate("2016-04-28T16:12:47.719Z"),\n'
printf '	"myState" : 1,\n'
printf '	"term" : NumberLong(1),\n'
printf '	"heartbeatIntervalMillis" : NumberLong(2000),\n'
printf '	"members" : [\n'
printf '		{\n'
printf '			"_id" : 0,\n'
printf '			"name" : "mongodb-1-3fbe1:27017",\n'
printf '			"health" : 1,\n'
printf '			"state" : 1,\n'
printf '			"stateStr" : "PRIMARY",\n'
printf '			"uptime" : 411,\n'
printf '			"optime" : {\n'
printf '				"ts" : Timestamp(1461859947, 1),\n'
printf '				"t" : NumberLong(1)\n'
printf '			},\n'
printf '			"optimeDate" : ISODate("2016-04-28T16:12:27Z"),\n'
printf '			"infoMessage" : "could not find member to sync from",\n'
printf '			"electionTime" : Timestamp(1461859946, 2),\n'
printf '			"electionDate" : ISODate("2016-04-28T16:12:26Z"),\n'
printf '			"configVersion" : 1,\n'
printf '			"self" : true\n'
printf '		}\n'
printf '	],\n'
printf '	"ok" : 1\n'
printf '}\n'

printf 'rs-minefield:PRIMARY> '
sleep 12
printf 'c = rs.conf()\n'
sleep 1
printf '{\n'
printf '	"_id" : "rs-minefield",\n'
printf '	"version" : 1,\n'
printf '	"protocolVersion" : NumberLong(1),\n'
printf '	"members" : [\n'
printf '		{\n'
printf '			"_id" : 0,\n'
printf '			"host" : "mongodb-1-3fbe1:27017",\n'
printf '			"arbiterOnly" : false,\n'
printf '			"buildIndexes" : true,\n'
printf '			"hidden" : false,\n'
printf '			"priority" : 1,\n'
printf '			"tags" : {\n'
printf '				\n'
printf '			},\n'
printf '			"slaveDelay" : NumberLong(0),\n'
printf '			"votes" : 1\n'
printf '		}\n'
printf '	],\n'
printf '	"settings" : {\n'
printf '		"chainingAllowed" : true,\n'
printf '		"heartbeatIntervalMillis" : 2000,\n'
printf '		"heartbeatTimeoutSecs" : 10,\n'
printf '		"electionTimeoutMillis" : 10000,\n'
printf '		"getLastErrorModes" : {\n'
printf '			\n'
printf '		},\n'
printf '		"getLastErrorDefaults" : {\n'
printf '			"w" : 1,\n'
printf '			"wtimeout" : 0\n'
printf '		},\n'
printf '		"replicaSetId" : ObjectId("5722366a4faa5bd8e566a9e2")\n'
printf '	}\n'
printf '}\n'
printf 'rs-minefield:PRIMARY> '
sleep 4
printf 'c.members[0].host = "mongodb-1:27017"\n'
sleep 1
printf 'mongodb-1:27017\n'
printf 'rs-minefield:PRIMARY> '
sleep 4
printf 'rs.reconfig(c)\n'
sleep 1
printf '{ "ok" : 1 }\n'
printf 'rs-minefield:PRIMARY> '
sleep 4
printf 'rs.add("mongodb-2:27017")\n'
printf '{ "ok" : 1 }\n'
printf 'rs-minefield:PRIMARY> '
sleep 2
printf 'rs.add("mongodb-3:27017")\n'
printf '{ "ok" : 1 }\n'
printf 'rs-minefield:PRIMARY> '
sleep 3

printf 'rs.status()\n'
printf '{\n'
printf '	"set" : "rs-minefield",\n'
printf '	"date" : ISODate("2016-04-28T16:14:03.793Z"),\n'
printf '	"myState" : 1,\n'
printf '	"term" : NumberLong(1),\n'
printf '	"heartbeatIntervalMillis" : NumberLong(2000),\n'
printf '	"members" : [\n'
printf '		{\n'
printf '			"_id" : 0,\n'
printf '			"name" : "mongodb-1:27017",\n'
printf '			"health" : 1,\n'
printf '			"state" : 1,\n'
printf '			"stateStr" : "PRIMARY",\n'
printf '			"uptime" : 487,\n'
printf '			"optime" : {\n'
printf '				"ts" : Timestamp(1461860038, 1),\n'
printf '				"t" : NumberLong(1)\n'
printf '			},\n'
printf '			"optimeDate" : ISODate("2016-04-28T16:13:58Z"),\n'
printf '			"infoMessage" : "could not find member to sync from",\n'
printf '			"electionTime" : Timestamp(1461859946, 2),\n'
printf '			"electionDate" : ISODate("2016-04-28T16:12:26Z"),\n'
printf '			"configVersion" : 4,\n'
printf '			"self" : true\n'
printf '		},\n'
printf '		{\n'
printf '			"_id" : 1,\n'
printf '			"name" : "mongodb-2:27017",\n'
printf '			"health" : 1,\n'
printf '			"state" : 2,\n'
printf '			"stateStr" : "SECONDARY",\n'
printf '			"uptime" : 7,\n'
printf '			"optime" : {\n'
printf '				"ts" : Timestamp(1461860038, 1),\n'
printf '				"t" : NumberLong(1)\n'
printf '			},\n'
printf '			"optimeDate" : ISODate("2016-04-28T16:13:58Z"),\n'
printf '			"lastHeartbeat" : ISODate("2016-04-28T16:14:02.936Z"),\n'
printf '			"lastHeartbeatRecv" : ISODate("2016-04-28T16:13:58.917Z"),\n'
printf '			"pingMs" : NumberLong(4),\n'
printf '			"syncingTo" : "mongodb-1:27017",\n'
printf '			"configVersion" : 4\n'
printf '		},\n'
printf '		{\n'
printf '			"_id" : 2,\n'
printf '			"name" : "mongodb-3:27017",\n'
printf '			"health" : 1,\n'
printf '			"state" : 2,\n'
printf '			"stateStr" : "SECONDARY",\n'
printf '			"uptime" : 4,\n'
printf '			"optime" : {\n'
printf '				"ts" : Timestamp(1461860038, 1),\n'
printf '				"t" : NumberLong(1)\n'
printf '			},\n'
printf '			"optimeDate" : ISODate("2016-04-28T16:13:58Z"),\n'
printf '			"lastHeartbeat" : ISODate("2016-04-28T16:14:02.936Z"),\n'
printf '			"lastHeartbeatRecv" : ISODate("2016-04-28T16:13:59.952Z"),\n'
printf '			"pingMs" : NumberLong(4),\n'
printf '			"configVersion" : 4\n'
printf '		}\n'
printf '	],\n'
printf '	"ok" : 1\n'
printf '}\n'

sleep 15





printf '$\n'
