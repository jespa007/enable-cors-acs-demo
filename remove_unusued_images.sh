#! /bin/bash

if [ "$ACS_TAG" == "" ]
then
	echo "ACS_TAG is empty"
fi

if [ "$SHARE_TAG" == "" ]
then
	echo "SHARE_TAG is empty"
fi


if [ "$ASS_TAG" == "" ]
then
	echo "ASS_TAG is empty"
fi

docker rmi alfresco/alfresco-content-repository-community:$ACS_TAG
docker rmi alfresco/alfresco-share:$SHARE_TAG
docker rmi alfresco/alfresco-search-services:$ASS_TAG
