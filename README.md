# VPC内のElasticsearch(Kibana)を参照するサンプル

## 構成図

![image](./images/image.png)

### RDPへの接続

My IP Addressからのアクセスのみを許可したセキュリティグループ内に配置したWindows ServerへRDPでアクセスする。

MacからのRDPアクセスは [こちら](https://dev.classmethod.jp/articles/mac-ec2-windows-rdp-connect) を参考にした。

### Kibanaへの接続

Windows Serverにログイン後IE等のブラウザからKibanaのURLをコピペしてアクセスする。
