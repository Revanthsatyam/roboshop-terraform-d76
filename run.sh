#PARAMETERS="catalogue.prod.DOCUMENTDB,DOCUMENTDB"
#for i in $PARAMETERS; do
#  aws_ssm_pm_1=$(echo "$i" | awk -F , '{print $1}')
#  aws_ssm_pm_2=$(echo "$i" | awk -F , '{print $2}')
#  export "${aws_ssm_pm_2}"=$(aws ssm get-parameter --name "${aws_ssm_pm_1}" --with-decryption --query "Parameter.Value" --output text)
#done

schema_type=DOCDB

aws_ssm() {
  aws ssm get-parameter --name "$1" --with-decryption --query "Parameter.Value"
}

if [ "${schema_type}" == "DOCDB" ]; then
  mongo_host=$(aws_ssm catalogue.prod.MONGO_URL)
  user_name=$(aws_ssm docdb.prod.master_username)
  password=$(aws_ssm docdb.prod.master_password)

  sh "mongo --ssl --host $mongo_host:27017 --sslCAFile /home/centos/catalogue/rds-combined-ca-bundle.pem --username $user_name --password $password </home/centos/catalogue/schema/catalogue.js"
fi