#!/bin/bash

# Create main directory
mkdir submission_reminder_app

# Create subdirectories
mkdir submission_reminder_app/app
mkdir submission_reminder_app/modules
mkdir submission_reminder_app/assets
mkdir submission_reminder_app/config

# Create files and add content
echo '# This is the config file' > submission_reminder_app/app/reminder.sh
echo 'ASSIGNMENT="Shell Navigation"' >> submission_reminder_app/app/reminder.sh
echo 'DAYS_REMAINING=2' >> submission_reminder_app/app/reminder.sh

echo '#!/bin/bash' > submission_reminder_app/modules/functions.sh
echo 'source ./config/config.env' >> submission_reminder_app/modules/functions.sh
echo 'source ./modules/functions.sh' >> submission_reminder_app/modules/functions.sh
echo 'submissions_file="./assets/submissions.txt"' >> submission_reminder_app/modules/functions.sh
echo 'echo "Assignment: $ASSIGNMENT"' >> submission_reminder_app/modules/functions.sh
echo 'echo "Days remaining to submit: $DAYS_REMAINING days"' >> submission_reminder_app/modules/functions.sh
echo 'check_submissions $submissions_file' >> submission_reminder_app/modules/functions.sh

echo '#!/bin/bash' > submission_reminder_app/config/config.env
echo 'function check_submissions {' >> submission_reminder_app/config/config.env
echo '    local submissions_file=$1' >> submission_reminder_app/config/config.env
echo '    echo "Checking submissions in $submissions_file"' >> submission_reminder_app/config/config.env
echo '    while IFS=, read -r student assignment status; do' >> submission_reminder_app/config/config.env
echo '        student=$(echo "$student" | xargs)' >> submission_reminder_app/config/config.env
echo '        assignment=$(echo "$assignment" | xargs)' >> submission_reminder_app/config/config.env
echo '        status=$(echo "$status" | xargs)' >> submission_reminder_app/config/config.env
echo '        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then' >> submission_reminder_app/config/config.env
echo '            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"' >> submission_reminder_app/config/config.env
echo '        fi' >> submission_reminder_app/config/config.env
echo '    done < <(tail -n +2 "$submissions_file")' >> submission_reminder_app/config/config.env
echo '}' >> submission_reminder_app/config/config.env

# Create submissions.txt and add records
echo "Student Name,Assignment,Status" > submission_reminder_app/assets/submissions.txt
echo "John Doe,Shell Navigation,not submitted" >> submission_reminder_app/assets/submissions.txt
echo "Jane Smith,Shell Navigation,submitted" >> submission_reminder_app/assets/submissions.txt
echo "Alice Johnson,Shell Navigation,not submitted" >> submission_reminder_app/assets/submissions.txt
echo "Bob Brown,Shell Navigation,not submitted" >> submission_reminder_app/assets/submissions.txt
echo "Charlie White,Shell Navigation,submitted" >> submission_reminder_app/assets/submissions.txt
echo "Eve Davis,Shell Navigation,not submitted" >> submission_reminder_app/assets/submissions.txt

# Create the startup.sh file
echo '#!/bin/bash' > submission_reminder_app/startup.sh

# Make scripts executable
chmod +x submission_reminder_app/app/reminder.sh
chmod +x submission_reminder_app/modules/functions.sh
chmod +x submission_reminder_app/startup.sh

echo "Environment created successfully!"
