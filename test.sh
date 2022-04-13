vault audit enable file file_path=/vault/logs/vault-audit.log mode=744
curl http://localhost:8200/v1/sys/metrics?format=prometheus
vault secrets enable -path=kv/ kv
s.g7muwFKPD0FtsHrAzGMBH2I1
for i in {1..10}
  do
    printf "."
    vault kv put kv/$i-secret-10 id="$(uuidgen)" >> step4.log 2>&1
done


for i in {1..25}
  do
    printf "."
    vault kv put kv/$i-secret-25 id="$(uuidgen)" >> step4.log 2>&1
done

for i in {1..50}
  do
    printf "."
    vault kv put kv/$i-secret-50 id="$(uuidgen)" >> step4.log 2>&1
done


for i in {1..85}
  do
    printf "."
    vault token create -policy=default >> step4.log 2>&1
done