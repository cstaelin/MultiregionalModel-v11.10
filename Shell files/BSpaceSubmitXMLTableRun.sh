# set +v
# set -v

# Usage: BSpaceSubmitXMLTableRun.sh <model file> <experiment name> < table file> <# threads>

# find out what directory we were started from, and save that.
NETLOGO_CWD=$(pwd)

# Now save the "model", "experiment" and output file arguments in local environment
# variables so that our NetLogo model and BehaviorSpace can get at them.
# Note that we need to export them.
export NETLOGO_MODEL=$1
export NETLOGO_EXPERIMENT=$2
export NETLOGO_TABLEFILE=$3

# See if the number of threads has been specified.
# If not, default to 4.
if [ "$#" -eq 4 ] 
then NETLOGO_THREADS=$4 
else NETLOGO_THREADS=4
fi

# Here are two ways to strip the filetype off the output file. 
# They both will handle more than one period, stripping only what comes
# after the last one.
# NETLOGO_OUTPUTFILEROOT=$(echo $NETLOGO_TABLEFILE | rev | cut -d"." -f1 | rev)
NETLOGO_OUTPUTFILEROOT=${NETLOGO_TABLEFILE%.*}

# get our home directory so that we can move around our directory tree if we want.
NETLOGO_USERDIR=$HOME

# set the locations for the model file, xml experiment file, and data and output files. 
NETLOGO_MODEL_DIR=$NETLOGO_CWD
export NETLOGO_EXPERIMENT_DIR=$NETLOGO_MODEL_DIR/$NETLOGO_EXPERIMENT
export NETLOGO_DATA_DIR=$NETLOGO_EXPERIMENT_DIR/data
export NETLOGO_RESULTS_DIR=$NETLOGO_EXPERIMENT_DIR/results
NETLOGO_MODEL=$NETLOGO_MODEL_DIR/$NETLOGO_MODEL
NETLOGO_EXPERIMENTFILE=$NETLOGO_EXPERIMENT_DIR/$NETLOGO_EXPERIMENT.xml
NETLOGO_TABLEFILE=$NETLOGO_RESULTS_DIR/$NETLOGO_TABLEFILE
NETLOGO_ERRORFILE=$NETLOGO_RESULTS_DIR/$NETLOGO_OUTPUTFILEROOT-stderr.txt
NETLOGO_STDOUTFILE=$NETLOGO_RESULTS_DIR/$NETLOGO_OUTPUTFILEROOT-stdout.txt

echo " "
echo The Model file is $NETLOGO_MODEL.
echo The experiment is $NETLOGO_EXPERIMENT in file $NETLOGO_EXPERIMENTFILE.
echo The BS table file is $NETLOGO_TABLEFILE.
echo The jave stdout file is $NETLOGO_STDOUTFILE.
echo The java error file is $NETLOGO_ERRORFILE.
echo $NETLOGO_THREADS threads will be used.
echo " "

# to get at the NetLogo extensions, we need to run this from the NetLogo
# directory, as specified by NETLOGO_ROOT. 
cd $NETLOGO_ROOT

# Clear the stdout and stderr files with a header giving the date and time.
echo "Experiment $NETLOGO_EXPERIMENT started: $(date)" > $NETLOGO_STDOUTFILE
echo "Experiment $NETLOGO_EXPERIMENT started: $(date)" > $NETLOGO_ERRORFILE

# Now run the model headless and in the background with the nohup qualifier 
# to allow it to continue running even if we disconnect from the node.
nohup java -server -XX:MaxPermSize=128m -Xmx2048M -cp netlogo.jar org.nlogo.headless.Main \
  --threads $NETLOGO_THREADS \
  --model "$NETLOGO_MODEL" \
  --setup-file "$NETLOGO_EXPERIMENTFILE" \
  --table "$NETLOGO_TABLEFILE" \
  1>>$NETLOGO_STDOUTFILE \
  2>>"$NETLOGO_ERRORFILE" &
  
echo The job has been sent to the backgroud.

# return to whence we began.
cd $NETLOGO_CWD

# read -p "Press [Enter] key to exit the shell ..."

exit
