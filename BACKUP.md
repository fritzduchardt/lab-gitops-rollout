## Restore DB

### From the cluster node

```
# n8n
ssh root@10.7.0.6
cd /volumes/n8n
psql -h n8n-rw.n8n -U app -d n8n < postgres_backup_20251203_220001.sql
```
### From localhost

```
#n8n
/home/fritz/projects/github/lab-ansible/roles/scripts/files/restic.sh restore "s3.eu-central-3.ionoscloud.com" "/volumes/n8n" "EEAAAAHdX92sjm9GXZjgsk28rzYOLC4VnCvXW8ats-REDUCTED" "jVFeUwBwWRCgYvkJTinlqPDQFHHv-REDUCTED" "REDUCTED"
ssh root@10.7.0.6 socat TCP-LISTEN:5432,reuseaddr,fork TCP:n8n-rw.n8n:5432
psql -h 10.7.0.6 -U app -d n8n < postgres_backup_20251203_220001.sql
```
