# AWXの構築手順

当リポジトリはAWXをAnsibleで構築するもの  
デプロイ先がAWS EC2インスタンスの場合は、最低`t2.small`以上のインスタンスにしてください  
t2.microだとメモリ不足でフリーズします

## 準備

すでに手元でansibleが実行できる場合は、手順7を実行してください

1. デプロイ先のホストIPを`ansible/inventories/hosts`の`ansible_host`に追加
2. デプロイ先のssh接続鍵を`ansible/inventories/hosts`の`ansible_ssh_private_key_file`に追加  
    ssh鍵は`ansible/ssh`に配置
3. デプロイ先の接続ユーザを変更する場合は、`inventories/hosts`の`ansible_user`を変更  
    `ansible/inventories/awx.yml`の`work_user`と`work_dir`も併せて変更してください
4. Dockerの導入
5. `docker-compose up --build -d`でAnsible実行コンテナを起動
6. `docker exec -it awx-ansible /bin/bash`でコンテナにログイン
7. `ansible-playbook -i /ansible/inventories/hosts /ansible/awx.yml`でインストール