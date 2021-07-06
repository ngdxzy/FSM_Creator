Create FSM code for copy..

In oder to change the states and variables:
sed -i -n 's/STATES=.*$/STATES=(S1 S2 S3)/' create_FSM.sh
sed -i -n 's/VARIABLES=.*$/VARIABLES=(S1 S2 S3)/' create_FSM.sh
