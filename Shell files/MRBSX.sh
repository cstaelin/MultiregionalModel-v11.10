# See if the number of threads has been specified.
if [ "$#" -eq 2 ] 
then THREADS=$2 
else THREADS=8
fi

sh $NETLOGO_ROOT/batch-files/BSpaceSubmitXMLTableRun.sh "Multiregional_Model.nlogo" $1 "$1.csv" $THREADS
