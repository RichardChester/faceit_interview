# DevOps Challenge




# Architecture

![enter image description here](https://github.com/RichardChester/faceit_interview/blob/main/Untitled%20Diagram.drawio.png?raw=true)
api gateway -> lambda -> database in private subnet
## Scale

it will scale at a near infinite level as a result of being deployed on lambda and api gateway

## Security

Lambda is inherently secure due to it's limitations and APIGateway can be fitted with a myriad of AWS security services to bolster its already impressive security. Finally the fact the db sit's in a private subnet only accessible from inside the VPC protects all the data

## Running

I provided a MAKEFILE

## CICD

I'd use git hub actions and do the very standard plan and implement in conjunction with a feature -> dev -> master branch model

## Monitor and Alert

Grafana + Prometheus + Loki. Given that I've gone serverless with the compute the only real bottle neck would be the DB and so I would want to know when I was hitting my limits.

## Final thoughts
in a more real scenario I probably would have gone to the extra effort of setting up a connection pool and a serverless db to give me even greater scale and could potentially have even set up some basic monitoring with cloud watch in the infra repo. I would also have liked to have gone into a bit more detail in the CICD but this was already a very long test and as I don't really want to have to actually spin up actual infrastructure at my own expense for an interview (or really put the serious amount of time into mocking it) it would have been practically just sudo code anyway. 

## Final final thoughts
Please don't give this to any one else as a technical test it really doesn't work on multiple levels
