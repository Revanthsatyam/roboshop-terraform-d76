#PARAMETERS="catalogue.prod.DOCUMENTDB,DOCUMENTDB"
#for i in $PARAMETERS; do
#  aws_ssm_pm_1=$(echo "$i" | awk -F , '{print $1}')
#  aws_ssm_pm_2=$(echo "$i" | awk -F , '{print $2}')
#  export "${aws_ssm_pm_2}"=$(aws ssm get-parameter --name "${aws_ssm_pm_1}" --with-decryption --query "Parameter.Value" --output text)
#done

#schema_type=DOCDB
#
#if [ "${schema_type}" == "DOCDB" ]; then
#
#fi

aws_ssm() {
  aws ssm get-parameter --name "$1" --with-decryption --query "Parameter.Value"
}

echo aws_ssm catalogue.prod.DOCUMENTDB