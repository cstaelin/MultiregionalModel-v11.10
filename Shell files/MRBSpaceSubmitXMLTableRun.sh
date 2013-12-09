# set +v
# set -v

# Usage: BSpaceHeadless.bat <model file> <experiment name> < output file>

# find out what directory we were started from, and save that.
NETLOGO_CWD=$(pwd)

# Now save the "model", "experiment" and output file arguments in local environment
# variables so that our NetLogo model and BehaviorSpace can get at them.
# Note that we need to export them.
export NETLOGO_MODEL=$1
export NETLOGO_EXPERIMENT=$2
export NETLOGO_OUTPUTFILE=$3
# Here are two ways to strip the filetype off the output file. 
# The both will handle more than one period, stripping only what comes
# after the last one.
# NETLOGO_OUTPUTFILEROOT=$(echo $NETLOGO_OUTPUTFILE | rev | cut -d"." -f1 | rev)
NETLOGO_OUTPUTFILEROOT=${NETLOGO_OUTPUTFILE%.*}

# get our home directory so that we can move around our directory tree if we want.
NETLOGO_USERDIR=$HOME

# set the locations for the model file and output files. 
NETLOGO_MODEL_DIR=$NETLOGO_CWD
NETLOGO_DATA_DIR=$NETLOGO_MODEL_DIR/data
NETLOGO_RESULTS_DIR=$NETLOGO_MODEL_DIR/results
NETLOGO_MODEL=$NETLOGO_MODEL_DIR/$NETLOGO_MODEL
NETLOGO_EXPERIMENTFILE=$NETLOGO_DATA_DIR/$NETLOGO_EXPERIMENT.xml
NETLOGO_OUTPUTFILE=$NETLOGO_RESULTS_DIR/$NETLOGO_OUTPUTFILE
NETLOGO_ERRORFILE=$NETLOGO_RESULTS_DIR/$NETLOGO_OUTPUTFILEROOT-stderr.txt
NETLOGO_MSSGFILE=$NETLOGO_RESULTS_DIR/$NETLOGO_OUTPUTFILEROOT-stdout.txt

echo " "
echo The Model file is $NETLOGO_MODEL.
echo The experiment is $NETLOGO_EXPERIMENT in file $NETLOGO_EXPERIMENTFILE.
echo The output file is $NETLOGO_OUTPUTFILE.
echo The message file is $NETLOGO_MSSGFILE.
echo The java error file is $NETLOGO_ERRORFILE.
echo " "

# to get at the NetLogo extensions, we need to run this from the NetLogo
# directory, as specified by NETLOGO_ROOT. 
cd $NETLOGO_ROOT

# Clear the stdout and stderr files with a header giving the date and time.
echo "Experiment $NETLOGO_EXPERIMENT started: $(date)" > $NETLOGO_MSSGFILE
echo "Experiment $NETLOGO_EXPERIMENT started: $(date)" > $NETLOGO_ERRORFILE

# Now run the model headless and in the background with the nohup qualifier 
# to allow it to continue running even if we disconnect from the node.
nohup java -server -XX:MaxPermSize=128m -Xmx2048M -cp netlogo.jar org.nlogo.headless.Main \
  --threads 8 \
  --model "$NETLOGO_MODEL" \
  --setup-file "$NETLOGO_EXPERIMENTFILE" \
  --table "$NETLOGO_OUTPUTFILE" \
  1>>$NETLOGO_MSSGFILE \
  2>>"$NETLOGO_ERRORFILE" &
  
echo The job has been sent to the backgroud.

# return to whence we began.
cd $NETLOGO_CWD

# read -p "Press [Enter] key to exit the shell ..."

exit
