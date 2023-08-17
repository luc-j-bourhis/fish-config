function az -d 'Add host and SAS for Azure Storage'
    if not set -q AZURE_HOST
        echo 'Please define environment variable AZURE_HOST'
        return 1
    end
    if not set -q AZURE_SAS
        echo 'Please define environment variable AZURE_SAS: its value is the shared access secret chosen in Azure storage manager'
        return 1
    end
    echo "$AZURE_HOST/$argv[1]$AZURE_SAS"
end

