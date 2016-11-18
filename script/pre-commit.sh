#!/bin/bash

function find_rejected {
  find $FILES_TO_COMMIT | \
      egrep  $FILES_PATTERN | \
      xargs egrep --with-filename -n $FORBIDDEN >> $LOGFILE
}

LOGFILE='log/commit-rejected.log'
rm $LOGFILE
touch $LOGFILE
FILES_TO_COMMIT=$(git diff --cached --name-only)
EVER_FORBIDDEN='[[:space:]]$'

# ruby
FILES_PATTERN='\.(rb$)'
FORBIDDEN_FOR_TYPE='byebug'
FORBIDDEN=$EVER_FORBIDDEN'|'$FORBIDDEN_FOR_TYPE
find_rejected

[[ -s $LOGFILE ]] && echo 'COMMIT REJECTED Found "$FORBIDDEN" references. Please remove them before commiting' && exit 1

exit 0
