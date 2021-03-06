#!/bin/bash
if [ $# == 2 ]
then
    STATES=(`echo $1 | tr ',' ' '`)
    VARIABLES=(`echo $2 | tr ',' ' '`)
else
    STATES=(S1 S2 S3)
    VARIABLES=(V1 V2 V3)
fi

CLK_NAME=clk
RST_NAME=rst
RST_PLAR=P

STATE_NUMBER=${#STATES[*]}
VAR_NUMBERS=${#VARIABLES[*]}


i=0
j=1
while(($i < $STATE_NUMBER))
do
    echo "    localparam ${STATES[i]} = ${STATE_NUMBER}'d${j};"
    let "i++"
    let "j*=2"
done
echo ""

echo "    reg [${STATE_NUMBER}-1 : 0] state,next_state;"
i=0
while(($i < $VAR_NUMBERS))
do
    echo "    reg ${VARIABLES[i]};"
    let "i++"
done
echo ""

echo "    always @ (posedge ${CLK_NAME}) begin"

if [ ${RST_PLAR} == P ]
then
    echo "        if(${RST_NAME} == 1) begin"
else
    echo "        if(${RST_NAME} == 0) begin"
fi

echo "            state <= ${STATES[0]};"
echo "        end"
echo "        else begin"
echo "            state <= next_state;"
echo "        end"
echo "    end"

echo "    always @ (*) begin"

i=0
while(($i < $VAR_NUMBERS))
do
    echo "        ${VARIABLES[i]} = 0;"
    let "i++"
done
echo "        next_state = state;"
echo "        case(state)"



i=0
while(($i < $STATE_NUMBER))
do
    echo "        ${STATES[i]}:begin"
    echo "            next_state = state;"
    echo "        end"
    let "i++"
done

echo "        default:begin"
echo "            next_state = state;"
echo "        end"
echo "        endcase"
echo "    end"
