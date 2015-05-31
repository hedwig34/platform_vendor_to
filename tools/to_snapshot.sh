#!/bin/sh
#
# Team Octos source snapshot tool
#
# The snapshot tool cycles thourgh the manifest and creates a script that
# contains the commands to set all repos back the position when the snapshot
# script was created.
#

TO_SNAPSHOT_TIME=`date -u +%Y%m%d-%H%M`
TO_SNAPSHOT=snapshot_$TO_SNAPSHOT_TIME.sh

touch $TO_SNAPSHOT

# Print something to build output
echo "Generating snapshot script $TO_SNAPSHOT..."

    echo '#!/bin/sh' >> $TO_SNAPSHOT
    echo '#' >> $TO_SNAPSHOT
    echo '# Team Octos source snapshot script' >> $TO_SNAPSHOT
    echo '#' >> $TO_SNAPSHOT
    echo '# Time of this snapshot: '$TO_SNAPSHOT_TIME >> $TO_SNAPSHOT
    echo '#' >> $TO_SNAPSHOT
    echo '# This file contains commands to set each repo to the position' >> $TO_SNAPSHOT
    echo '# when this snapshot was taken' >> $TO_SNAPSHOT
    echo '#' >> $TO_SNAPSHOT
    echo >> $TO_SNAPSHOT;
    echo 'CUR_DIR=`pwd`' >> $TO_SNAPSHOT
    echo >> $TO_SNAPSHOT;

    # Cycle through every repo and grab the last commit number
    # and modify it to produce the commands we need to sync the
    # repos to the time of this TO_SNAPSHOT.
    repo --color=never forall -pc 'git log -n 1 | head -1 | \
        sed s/"commit "/"git checkout "/' | \
        sed s/'project '/'cd $ANDROID_BUILD_TOP\/'/ >> $TO_SNAPSHOT
    echo >> $TO_SNAPSHOT;
    echo 'cd $CUR_DIR' >> $TO_SNAPSHOT

chmod +x $TO_SNAPSHOT
