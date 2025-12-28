[gcs]
type = google cloud storage
project_number = op://Automation/gcp_sa_backup/project_id
service_account_credentials = op://Automation/gcp_sa_backup/tf-nblagoev-prod-c9fcf6bb671a.json
object_acl = private
bucket_acl = private
bucket_policy_only = true
location = europe-north1

[ironforge]
type = smb
host = 10.0.50.2
user = svc-tmfs-nblagoev
pass = op://Automation/rclone_crypt/obscured/ironforge_password

[sec]
type = crypt
remote = op://Automation/rclone_crypt/remote
password = op://Automation/rclone_crypt/obscured/sec_password
password2 = op://Automation/rclone_crypt/obscured/sec_password2
